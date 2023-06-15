class JobsModel{
  late var id, title, job_type, company_name, company_logo, location, description, responsibilities, salary, skills, experience, created_by, status;

  JobsModel(
      {required this.id,
        this.title,
        this.job_type,
        this.company_name,
        this.company_logo,
        this.location,
        this.description,
        this.responsibilities,
        this.salary,
        this.skills,
        this.experience,
        this.created_by,
        this.status
      });
}