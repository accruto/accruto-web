class LinkMe

  def initialize
    ## use this with database.yml
    ## attr = Rails.configuration.database_configuration["linkme"].symbolize_keys

    ## use this with database url - heroku db config style
    db = URI.parse(ENV['LINKME_DATABASE_URL'])
    @client = TinyTds::Client.new(username: db.user, password: db.password, host: db.host, timeout: 0)
  end

  def candidate_resumes
    query = %{
      SELECT TOP 100 * FROM candidateresume
      LEFT OUTER JOIN resume
      on candidateresume.resume_id = resume.id
    }
    @client.execute(query)
  end

  def resumes
    query = %{
      SELECT TOP 5 * FROM resume
    }
    @client.execute(query)
  end

  def candidate_searches
    query = %{
      DECLARE @startDate DATETIME
      SET @startDate = '2013-09-01 00:00:00'
      DECLARE @endDate DATETIME
      SET @endDate = '2013-09-09 00:00:00'

      SELECT Isnull(u.loginid, 'Anonymous') AS LoginId,
         Isnull(e.contactphonenumber, '') AS ContactPhoneNumber,
         Isnull(u.firstname, '') AS FirstName,
         Isnull(u.lastname, '') AS LastName,
         Isnull(u.emailaddress, '') AS EmailAddress,
         Isnull(dbo.Getorganisationfullname(e.organisationid, ' '), 'Anonymous') AS
         Organisation,
         CASE
           WHEN ou.id IS NULL THEN 'Unverified'
           ELSE 'Verified'
         END AS OrganisationStatus,
         Isnull(dbo.Getlocationdisplaytext(lr.id), '') AS Location,
         CASE
           WHEN am.id IS NULL THEN ''
           ELSE am.firstname + ' ' + am.lastname
         END AS AccountManager,
         Isnull(Searches.total, 0) AS Searches,
         Isnull(CONVERT(NVARCHAR(100), dbo.Getavailableemployercredits(e.id, '571B8809-F368-49CE-88C6-34C8ECD7D2C7')), 'Unlimited') AS Credits,
         Isnull(Viewings.total, 0) AS Viewings,
         Isnull(Accesses.total, 0) AS Accesses
      FROM employer AS e
        LEFT OUTER JOIN (
          SELECT searcherid, Count(*) AS total
          FROM   dbo.resumesearch
            WHERE starttime >= @startDate
                  AND starttime < @endDate
                  AND context NOT LIKE '%suggested%'
            GROUP BY searcherid) AS Searches
          ON Searches.searcherid = e.id
        LEFT JOIN (SELECT employerid,
                    Count(DISTINCT memberid) AS total
                  FROM   memberviewing
                  WHERE time >= @startDate
                        AND time < @endDate
                  GROUP  BY employerid) AS Viewings ON Viewings.employerid = e.id
        LEFT JOIN (SELECT employerid,
                    Count(DISTINCT memberid) AS total
                  FROM   membercontact
                  WHERE  time >= @startDate
                         AND time < @endDate
                  GROUP  BY employerid) AS Accesses ON Accesses.employerid = e.id
        LEFT JOIN registereduser AS u ON u.id = e.id
        LEFT JOIN organisation AS o ON o.id = e.organisationid
        LEFT OUTER JOIN address AS a ON a.id = o.addressid
        LEFT OUTER JOIN locationreference AS lr ON lr.id = a.locationreferenceid
        LEFT OUTER JOIN organisationalunit AS ou ON ou.id = e.organisationid
        LEFT OUTER JOIN registereduser AS am ON am.id = ou.accountmanagerid
      WHERE u.emailaddress NOT LIKE '%linkme.com.au'
            AND ( Searches.total > 0
                  OR Viewings.total > 0
                  OR Accesses.total > 0 )
      ORDER  BY organisationstatus ASC,
                credits ASC,
                searches DESC,
                organisation ASC
    }

    @client.execute(query)
  end

  def recent_candidates #(datetime)
    limit = 10000
    last_migrate = MigrationTrack.last
    last_migrated_time = last_migrate && last_migrate.last_data_time ? last_migrate.last_data_time : '2005-06-10 00:00:00'

    query = %{
        DECLARE @startDate DATETIME
        SET @startDate = '2012-01-01 00:00:00'
        DECLARE @recentCandidateEndDate DATETIME
        SET @recentCandidateEndDate = '2014-05-05 00:00:00'

        SELECT
          u.id AS Id,
          u.createdTime as createdTime,
          u.firstName + ' ' + u.lastName AS Name,
          u.emailAddress AS Email,
          u.emailAddressVerified AS VerifiedEmail,
          dbo.GetJustDate(u.createdTime) AS Joined,
          dbo.GetJustDate(dbo.GetLatestDate(u.createdTime, c.lastEditedTime, r.lastEditedTime)) AS LastUpdated,
          dbo.GetJustDate((SELECT MAX(time) FROM dbo.UserLogin WHERE userId = u.id)) AS LastLoggedIn,
          CASE WHEN u.createdTime >= @startDate AND u.createdTime < @recentCandidateEndDate THEN 0 ELSE 1 END AS IsExisting,
          dbo.IsResumeEmpty(r.id) AS IsResumeEmpty,
          dbo.GetCandidateStatusDisplayText(c.status) AS Status,
          c.desiredJobTitle AS DesiredJobTitle,
          (SELECT TOP 1 title FROM dbo.ResumeJob WHERE resumeId = r.id ORDER BY startDate DESC) AS RecentJobTitle,
          dbo.GetSalaryDisplayText(c.desiredSalaryLower, c.desiredSalaryUpper, c.desiredSalaryRateType) AS Salary,
          dbo.GetLocationDisplayText(a.locationReferenceId) AS Location,
          dbo.GetRelocationPreferenceDisplayText(c.relocationPreference) AS Relocation,
          c.visaStatus,
          m.addressId,
          lr.unstructuredLocation,
          nl.displayName AS address_city,
          cs.ShortDisplayName as address_state,
          l.centroidLatitude AS address_latitude,
          l.centroidLongitude AS address_longitude,
          r.lensXml,
          r.courses,
          r.awards,
          r.skills,
          r.objective,
          r.summary,
          r.referees,
          i.displayName AS industry
        FROM
          dbo.RegisteredUser AS u
        INNER JOIN
          dbo.Member AS m ON m.id = u.id
        INNER JOIN
          dbo.Candidate AS c ON c.id = m.id
        LEFT OUTER JOIN
          dbo.CandidateResume AS cr ON cr.candidateId = c.id
        LEFT OUTER JOIN
          dbo.Resume AS r ON r.id = cr.resumeId
        LEFT OUTER JOIN
          dbo.Address AS a ON a.id = m.addressId
        LEFT OUTER JOIN
          dbo.LocationReference AS lr ON lr.id = a.locationReferenceId
        LEFT OUTER JOIN
          dbo.NamedLocation AS nl ON nl.id = lr.namedLocationId
        LEFT OUTER JOIN
          dbo.CountrySubdivision AS cs ON cs.id = lr.countrySubdivisionId
        LEFT OUTER JOIN
          dbo.Locality AS l ON l.id = lr.localityId
        LEFT OUTER JOIN
          dbo.ParsedResume AS pr ON pr.resumeId = r.id
        LEFT OUTER JOIN
          dbo.CandidateIndustry AS ci ON ci.candidateId = c.id
        LEFT OUTER JOIN
          dbo.Industry AS i ON i.id = ci.industryId

        ORDER BY createdTime
        OFFSET #{limit} ROWS
        FETCH NEXT #{limit} ROWS ONLY
      }

    #(
    #(u.createdTime >= @startDate AND u.createdTime < @recentCandidateEndDate)
    #OR
    #((NOT c.lastEditedTime IS NULL) AND c.lastEditedTime >= @startDate AND c.lastEditedTime < @recentCandidateEndDate)
    #OR
    #((NOT r.lastEditedTime IS NULL) AND r.lastEditedTime >= @startDate AND r.lastEditedTime < @recentCandidateEndDate)
    #AND
    #u.createdTime > '2009-01-06 20:23:52'
    #)

    @client.execute(query)
  end

  def candidate_industries
    query = %{
      SELECT TOP 5 *
      FROM CandidateIndustry ci
      LEFT JOIN Industry i ON (i.id = ci.industryId)
      LEFT JOIN Candidate c ON (c.id = ci.candidateId)
      LEFT JOIN Member m ON m.id = c.id
      LEFT JOIN RegisteredUser u ON u.id = m.id
    }

    @client.execute(query)
  end
end