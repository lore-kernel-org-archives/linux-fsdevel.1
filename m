Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085813D539
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776728509; cv=none; b=ocEE4QTwXm3FGlT+m5kX/WoIha17onIuoUD1ju8URdzpkhGY1mYcqWnfrigFgwjZ3AAMcJYEeiDrO66v2YCjXtJ0uksnyBZp+AGI1WyPcgI/oSHSIsFRl74dq/yAISGvCauSBlmuqOCy/+uD4jAD8MVbZ4U9cZgMwX+i0LBzRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776728509; c=relaxed/simple;
	bh=SMxla0uk/OMNMfq7ReUy4nda1nJ6w/OK/RxIdqCrYN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbiLNUwe3EyqEgVGIR5INuNJvTP1JnkaTgi3hwf3yYdN0cM5JvD0YdD0F8Pv3Xau5wGd9XXPluSbspuXCTTGTuC2JT9g4g2lKn9XMtMh257+UJAm0jv8s8KosMjXOE5BafBwJ/pcBEQ2G6OlG0G7D8XKmLAwRbDxf8GzRMUbRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYBEursB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYBEursB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16EBC19425;
	Mon, 20 Apr 2026 23:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776728508;
	bh=SMxla0uk/OMNMfq7ReUy4nda1nJ6w/OK/RxIdqCrYN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYBEursBkNKycBMHHxdyCjpWuvhm/FxTs6RMoPz2Js5Ul3QNct/P2lSmnhdNHCHsN
	 n58fyYV8Gh9r7JJ8eIzF0nKOOf0UoHfKrCo2FeRTCb1npDZx5mOHiqLHKlLvj+OHZV
	 XU0T25D2RsJJH52Q4sYYFHW3B3BjpjMtlnTFY+u8T79iRNvMsZe4nXBtD0CI+m517G
	 KEaOBliyYhHVLgOB8Z9HKzVwXYbSOvaFB7SvTwKjulNYF5mMGCNOZK76NruJbXYHf4
	 sP+JbFMrXl+bwaH7z2eMOPWXljocnwq+XLPXWUwk47qVgKLdTtH7ZZgVK5OqWtbyXe
	 p+Wosrvgk4j/Q==
Date: Mon, 20 Apr 2026 16:41:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 09/13] mount.fuse3: integrate systemd service startup
Message-ID: <20260420234148.GQ7727@frogsfrogsfrogs>
References: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
 <177577270377.2064074.11749808216143618873.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177577270377.2064074.11749808216143618873.stgit@frogsfrogsfrogs>

On Thu, Apr 09, 2026 at 03:22:53PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Teach mount.fuse3 how to start fuse via systemd service, if present.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  util/mount_service.h  |    8 +++
>  doc/fuservicemount3.8 |   10 +++-
>  meson.build           |    3 +
>  util/fuservicemount.c |   48 +++++++++++++++++
>  util/meson.build      |   14 ++++-
>  util/mount.fuse.c     |  135 +++++++++++++++++++++++++++++++++++++++++--------
>  util/mount_service.c  |   28 ++++++++++
>  7 files changed, 219 insertions(+), 27 deletions(-)
> 
> 
> diff --git a/util/mount_service.h b/util/mount_service.h
> index f1f95e67ee1afe..993414ea3422e9 100644
> --- a/util/mount_service.h
> +++ b/util/mount_service.h
> @@ -36,4 +36,12 @@ int mount_service_main(int argc, char *argv[]);
>   */
>  const char *mount_service_subtype(const char *fstype);
>  
> +/**
> + * Discover if there is a fuse service socket for the given fuse subtype.
> + *
> + * @param subtype the subtype of a fuse filesystem type (e.g. Y from fuse.Y)
> + * @return true if available, false if not
> + */
> +bool mount_service_present(const char *subtype);
> +
>  #endif /* MOUNT_SERVICE_H_ */
> diff --git a/doc/fuservicemount3.8 b/doc/fuservicemount3.8
> index e45d6a89c8b81a..aa2167cb4872c6 100644
> --- a/doc/fuservicemount3.8
> +++ b/doc/fuservicemount3.8
> @@ -7,12 +7,20 @@ .SH SYNOPSIS
>  .B mountpoint
>  .BI -t " fstype"
>  [
> -.I options
> +.BI -o " options"
>  ]
> +
> +.B fuservicemount3
> +.BI -t " fstype"
> +.B --check
> +
>  .SH DESCRIPTION
>  Mount a filesystem using a FUSE server that runs as a socket service.
>  These servers can be contained using the platform's service management
>  framework.
> +
> +The second form checks if there is a FUSE service available for the given
> +filesystem type.
>  .SH "AUTHORS"
>  .LP
>  The author of the fuse socket service code is Darrick J. Wong <djwong@kernel.org>.
> diff --git a/meson.build b/meson.build
> index c8326b79fcee8f..827ec45ad3ad75 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -83,7 +83,8 @@ private_cfg.set('FUSE_SERVICE_SOCKET_PERMS', service_socket_perms)
>  # Test for presence of some functions
>  test_funcs = [ 'fork', 'fstatat', 'openat', 'readlinkat', 'pipe2',
>                 'splice', 'vmsplice', 'posix_fallocate', 'fdatasync',
> -               'utimensat', 'copy_file_range', 'fallocate', 'fspacectl' ]
> +               'utimensat', 'copy_file_range', 'fallocate', 'fspacectl',
> +               'faccessat' ]
>  foreach func : test_funcs
>      private_cfg.set('HAVE_' + func.to_upper(),
>          cc.has_function(func, prefix: include_default, args: args_default))
> diff --git a/util/fuservicemount.c b/util/fuservicemount.c
> index 9c694a4290f94e..d39d9c486c8997 100644
> --- a/util/fuservicemount.c
> +++ b/util/fuservicemount.c
> @@ -9,10 +9,58 @@
>   * This program wraps the mounting of FUSE filesystems that run in systemd
>   */
>  #define _GNU_SOURCE
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdlib.h>
>  #include "fuse_config.h"
>  #include "mount_service.h"
>  
> +static int check_service(const char *fstype)
> +{
> +	const char *subtype;
> +
> +	if (!fstype) {
> +		fprintf(stderr,
> +			"fuservicemount: expected fs type for --check\n");
> +		return EXIT_FAILURE;
> +	}
> +
> +	subtype = mount_service_subtype(fstype);
> +	return mount_service_present(subtype) ? EXIT_SUCCESS : EXIT_FAILURE;
> +}
> +
>  int main(int argc, char *argv[])
>  {
> +	char *fstype = NULL;
> +	bool check = false;
> +	int i;
> +
> +	/*
> +	 * If the user passes us exactly the args -t FSTYPE --check then
> +	 * we'll just check if there's a service for the FSTYPE fuse server.
> +	 */
> +	for (i = 1; i < argc; i++) {
> +		if (!strcmp(argv[i], "--check")) {
> +			if (check) {
> +				check = false;
> +				break;
> +			}
> +			check = true;
> +		} else if (!strcmp(argv[i], "-t") && i + 1 < argc) {
> +			if (fstype) {
> +				check = false;
> +				break;
> +			}
> +			fstype = argv[i + 1];
> +			i++;
> +		} else {
> +			check = false;
> +			break;
> +		}
> +	}
> +	if (check)
> +		return check_service(fstype);
> +
>  	return mount_service_main(argc, argv);
>  }
> diff --git a/util/meson.build b/util/meson.build
> index aa646ef3c77d16..85b54d5d322dcb 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -6,21 +6,27 @@ executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c
>             install_dir: get_option('bindir'),
>             c_args: '-DFUSE_CONF="@0@"'.format(fuseconf_path))
>  
> +mount_service_sources = []
> +mount_service_cflags = []
>  if private_cfg.get('HAVE_SERVICEMOUNT', false)
> -  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c', 'fuser_conf.c'],
> +  mount_service_sources += ['mount_service.c', '../lib/mount_util.c', 'fuser_conf.c']
> +  mount_service_cflags += ['-DFUSE_CONF="@0@"'.format(fuseconf_path)]
> +  fuservicemount_path = join_paths(get_option('prefix'), get_option('sbindir'))
> +  mount_service_cflags += ['-DFUSERVICEMOUNT_DIR="@0@"'.format(fuservicemount_path)]
> +  executable('fuservicemount3', ['fuservicemount.c'] + mount_service_sources,
>               include_directories: include_dirs,
>               link_with: [ libfuse ],
>               install: true,
>               install_dir: get_option('sbindir'),
> -             c_args: ['-DFUSE_USE_VERSION=319', '-DFUSE_CONF="@0@"'.format(fuseconf_path)])
> +             c_args: ['-DFUSE_USE_VERSION=319'] + mount_service_cflags)
>  endif
>  
> -executable('mount.fuse3', ['mount.fuse.c'],
> +executable('mount.fuse3', ['mount.fuse.c'] + mount_service_sources,
>             include_directories: include_dirs,
>             link_with: [ libfuse ],
>             install: true,
>             install_dir: get_option('sbindir'),
> -           c_args: '-DFUSE_USE_VERSION=317')
> +           c_args: ['-DFUSE_USE_VERSION=319'] + mount_service_cflags)
>  
>  
>  udevrulesdir = get_option('udevrulesdir')
> diff --git a/util/mount.fuse.c b/util/mount.fuse.c
> index ec56198ccc1cf0..8836eba8502fd1 100644
> --- a/util/mount.fuse.c
> +++ b/util/mount.fuse.c
> @@ -49,6 +49,9 @@
>  #endif
>  
>  #include "fuse.h"
> +#ifdef HAVE_SERVICEMOUNT
> +# include "mount_service.h"
> +#endif
>  
>  static char *progname;
>  
> @@ -233,6 +236,77 @@ static void drop_and_lock_capabilities(void)
>  }
>  #endif
>  
> +#ifdef HAVE_SERVICEMOUNT
> +#define FUSERVICEMOUNT_PROG	"fuservicemount3"
> +
> +static int try_service_main(char *argv0, char *type, char *source,
> +			    const char *mountpoint, char *options)
> +{
> +	const char *full_path = FUSERVICEMOUNT_DIR "/" FUSERVICEMOUNT_PROG;
> +	char **argv;
> +	char dash_o[] = "-o";
> +	char dash_t[] = "-t";
> +	char *mntpt = strdup(mountpoint);
> +	int argc = 5; /* argv[0], -t type, mountpoint, and trailing NULL */
> +	int i = 0;
> +	int ret;
> +
> +	if (!mount_service_present(type))
> +		return MOUNT_SERVICE_FALLBACK_NEEDED;
> +
> +	if (!mntpt) {
> +		perror("mountpoint allocation");
> +		return -1;
> +	}
> +
> +	if (source)
> +		argc++;
> +	if (options)
> +		argc += 2;
> +
> +	argv = calloc(argc, sizeof(char *));
> +	if (!argv) {
> +		perror("argv allocation");
> +		free(mntpt);
> +		return -1;
> +	}
> +
> +	argv[i++] = argv0;
> +	if (source)
> +		argv[i++] = source;
> +	argv[i++] = mntpt;
> +	argv[i++] = dash_t;
> +	argv[i++] = type;
> +	if (options) {
> +		argv[i++] = dash_o;
> +		argv[i++] = options;
> +	}
> +	argv[i] = 0;
> +
> +	if (getuid() != 0) {
> +		/*
> +		 * First try the install path, then a system install, just like
> +		 * we do for fusermount.
> +		 */
> +		ret = execvp(full_path, argv);
> +		if (ret)
> +			ret = execvp(FUSERVICEMOUNT_PROG, argv);
> +		if (ret) {
> +			fprintf(stderr, "%s: could not start %s helper: %s\n",
> +				argv[0], FUSERVICEMOUNT_PROG,
> +				strerror(errno));
> +			ret = MOUNT_SERVICE_FALLBACK_NEEDED;
> +		}
> +	} else {
> +		/* We're root, just do the mount directly. */
> +		ret = mount_service_main(argc - 1, argv);
> +	}
> +	free(argv);
> +	free(mntpt);
> +	return ret;
> +}
> +#endif
> +
>  int main(int argc, char *argv[])
>  {
>  	char *type = NULL;
> @@ -280,9 +354,7 @@ int main(int argc, char *argv[])
>  	mountpoint = argv[2];
>  
>  	for (i = 3; i < argc; i++) {
> -		if (strcmp(argv[i], "-v") == 0) {
> -			continue;
> -		} else if (strcmp(argv[i], "-t") == 0) {
> +		if (strcmp(argv[i], "-t") == 0) {
>  			i++;
>  
>  			if (i == argc) {
> @@ -303,6 +375,30 @@ int main(int argc, char *argv[])
>  					progname);
>  				exit(1);
>  			}
> +		}
> +	}
> +
> +	if (!type) {
> +		if (source) {
> +			dup_source = xstrdup(source);
> +			type = dup_source;
> +			source = strchr(type, '#');
> +			if (source)
> +				*source++ = '\0';
> +			if (!type[0]) {
> +				fprintf(stderr, "%s: empty filesystem type\n",
> +					progname);
> +				exit(1);
> +			}
> +		} else {
> +			fprintf(stderr, "%s: empty source\n", progname);
> +			exit(1);
> +		}
> +	}
> +
> +	for (i = 3; i < argc; i++) {
> +		if (strcmp(argv[i], "-v") == 0) {
> +			continue;
>  		} else	if (strcmp(argv[i], "-o") == 0) {
>  			char *opts;
>  			const char *opt;
> @@ -366,24 +462,6 @@ int main(int argc, char *argv[])
>  	if (suid)
>  		options = add_option("suid", options);
>  
> -	if (!type) {
> -		if (source) {
> -			dup_source = xstrdup(source);
> -			type = dup_source;
> -			source = strchr(type, '#');
> -			if (source)
> -				*source++ = '\0';
> -			if (!type[0]) {
> -				fprintf(stderr, "%s: empty filesystem type\n",
> -					progname);
> -				exit(1);
> -			}
> -		} else {
> -			fprintf(stderr, "%s: empty source\n", progname);
> -			exit(1);
> -		}
> -	}
> -
>  	if (setuid_name && setuid_name[0]) {
>  #ifdef linux
>  		if (drop_privileges) {
> @@ -429,6 +507,21 @@ int main(int argc, char *argv[])
>  		drop_and_lock_capabilities();
>  	}
>  #endif
> +
> +#ifdef HAVE_SERVICEMOUNT
> +	/*
> +	 * Now that we know the desired filesystem type, see if we can find
> +	 * a socket service implementing that, if we haven't selected any weird
> +	 * options that would prevent that.
> +	 */
> +	if (!pass_fuse_fd && !(setuid_name && setuid_name[0])) {
> +		int ret = try_service_main(argv[0], type, source, mountpoint,
> +					   options);
> +		if (ret != MOUNT_SERVICE_FALLBACK_NEEDED)
> +			return ret;
> +	}
> +#endif
> +
>  	add_arg(&command, type);
>  	if (source)
>  		add_arg(&command, source);
> diff --git a/util/mount_service.c b/util/mount_service.c
> index 0f7eae94ada377..f837595078f2d1 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -1836,3 +1836,31 @@ int mount_service_main(int argc, char *argv[])
>  	mount_service_destroy(&mo);
>  	return ret;
>  }
> +
> +bool mount_service_present(const char *fstype)
> +{
> +	struct stat stbuf;
> +	char path[PATH_MAX];
> +	int ret;
> +
> +	snprintf(path, sizeof(path), FUSE_SERVICE_SOCKET_DIR "/%s", fstype);

The maximum length of a path to a Unix socket is dictated (horrifyingly)
by sockaddr_un::sun_path, which is 112 bytes(!!)

Therefore, the return value of snprintf should be checked by the that
size because otherwise we could trick the --check predicate into
checking for the existence of the wrong socket.

--D

> +	ret = stat(path, &stbuf);
> +	if (ret)
> +		return false;
> +
> +	if (!S_ISSOCK(stbuf.st_mode))
> +		return false;
> +
> +#ifdef HAVE_FACCESSAT
> +	/*
> +	 * Can we write to the service socket with the real uid?  This accounts
> +	 * for setuid and ACLs on the socket.  Note that we connect() to the
> +	 * socket having dropped setuid privileges.
> +	 */
> +	ret = faccessat(AT_FDCWD, path, W_OK, 0);
> +#else
> +	/* Can we write to the service socket with the real uid? */
> +	ret = access(path, W_OK);
> +#endif
> +	return ret == 0;
> +}
> 
> 
