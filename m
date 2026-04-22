Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD00372680
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892851; cv=none; b=irfFWLMAuAW7eqpYQzO+WEjlHKUCGmwe2qOmZiIYU3Yd26X5ik4MsLoaDcFQaCP2wzHHcCpo0S7yA5F0wG+EUIUtrRRPiqlvHHrpPjVP+qe57HGot9TN0weO4jJ4hXJa8YS8/397KhJY59W1gsprFlVYXe9EPi3nz7MTWa5Dsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892851; c=relaxed/simple;
	bh=zUdrYTV9E+/N8GN8YTqRKwMR9RqaTKInOdArx3jEKdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBvE6SYmorvNE+uOlC7q733SC28Qn6l8t6DcsaiiKskObYmh0bjB7mQe1CZU//AspPWJKD/r3F3b8PpmGGBBJAGE2Z96Oruoe9sKF5lwl1uMVgmBKpVmWcjAIaRN6/HkOR13GOmceErT/RkvVFBb2tAI+W+xnaKtOVNKuaN3G1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMfG6H3+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMfG6H3+"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43fe8bda8e9so3165050f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 14:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776892847; x=1777497647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G1FxYB3JY2jCl3uwyPOOQ+11kmU8r0V3TYZNHka9I7s=;
        b=rMfG6H3+La8ityomwoudN0aPxKtB/U3BgSdGymcDHFh6GqF1/mrTcwCrQTxJD650zQ
         fYP27GvS/BKaDsSb+oyT+lNCFtTiH3/pbGYn2jS/e/8huUHdXiL46fVnbLk1ekXqLzit
         smhMddDIrU0RQ/W+RN79SZ/+8MO3FkXjFy20TUlF6RyLgacpv9Q3dxzzJD+CcTxO26r/
         g4OyibyzreTuzIVcDLTUMrJquNX6ha+4NMBPeI+sb7CPNha5mjcs9DUXv11yl5zhum+q
         unLe7nCnU9gKsg33JISnc8FEWroqGaJiPoOsICfiybIDoyY58rMm0qT4i+0HvEeavf+t
         frrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776892847; x=1777497647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1FxYB3JY2jCl3uwyPOOQ+11kmU8r0V3TYZNHka9I7s=;
        b=XHUepzaOOiN8jbY+5fd1wb9dUoUIEgW7qzMy13e/M5Q9i94oiLN4J5zGZ7HcGPpU7e
         xSzYu4+PfWtCGUQJkVT8jCCc5Ol/87N70KTMGowStQYbSjYVudHkvHAiSmrtC0HyHKdr
         EjX7oWRNPKlO/C8TSpV2h/yLu51u3glLDB6ECYnA4ZwgFLGmua1pKfwzPIdSd/cJhPmr
         s4Yr7KSl6vqo8kni+oeFIvSrnGmo19Xfw9PYCHRv3ZkT7d8moc4q2HYvs3JFs9PqEIl+
         0U355jM/14kgopr0o6sW+jmuvW61aPUGqYrj3bbafwCBgyX7/r42yi1XZVyhMolaNrDT
         72ig==
X-Forwarded-Encrypted: i=1; AFNElJ8wSsuMyS2c0hA1bU1gNZukSL/GoIo6W6rFgxlfUUvDF3CwSHpn1FyhDNkAsYJvVh+An+PNz927ruaCI/HZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTxr1+0idktuonDjnGKvab6W1kEc0WVXXcq+nwHwgNwgYpKwk
	LNmG8MmWcwiBZ4ycj71p6MVhw2028jiYPiBYMC/D1ymyVvhvhaZ9mGVY
X-Gm-Gg: AeBDieuSEHIAbFAeJtUSMoaDI8Ck1WoiHUcC+tOHtgRwEwdofdtuxjXmw+zwK5yTDK/
	BZ8Jb44S9IXExJ5jhV/KNvNLMqHvgLg+wBOs7S5jEKduUIHcfaD8eLmPlhLiLBfbhv7ir3zIiBd
	zih1q5gMauuFDXelif+e3ApRmO02MCp4ZEg5PmM1wzXoC8FPziVwKu2bVz4aTldc9/jnK7q4/yH
	xGYvyoqqn5rx6UPiP5WWx0Yn5QgqP2Up8Ui3LQjUuZ48JUUUZYqOZN3OUofa2lEQzVK/VQm3GnY
	cDDHjBm9VBEN199+6X4sMrUrHXuI3YM5Rgrpf+ozwktdOdP53nICKKyJJUDg6ZB04Hjc5C600x5
	I0xRJ06rngfZBD/F/waLCybp9mbJtasAJ2TWPKntgU9y7/t81UNO6hylnq2I02CVTpJpiQF5sz0
	un1MuFNmjY60pPQtblw3u9GxoFWAgKr0FPrq55bfot5MZZEKiIISdzuOD6KxU=
X-Received: by 2002:a05:6000:2dc6:b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-43fe3dfd5bbmr36774695f8f.27.1776892847056;
        Wed, 22 Apr 2026 14:20:47 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm53467720f8f.37.2026.04.22.14.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:20:46 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:20:45 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 10/11] samples/landlock: Add capability and
 namespace restriction support
Message-ID: <20260422.cd00ad04e709@gnoack.org>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-11-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-11-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:43AM +0100, Mickaël Salaün wrote:
> Extend the sandboxer sample to demonstrate the new Landlock capability
> and namespace restriction features.  The LL_CAPS environment variable
> takes a colon-delimited list of allowed capability numbers (e.g. "18"
> for CAP_SYS_CHROOT).  The LL_NS variable takes a colon-delimited list of
> allowed namespace types by short name (e.g.  "user:uts:net").  Update
> LANDLOCK_ABI_LAST to 9 and add best-effort degradation for older
> kernels.
> 
> Allow creating user and UTS namespaces but deny network namespaces
> (works as an unprivileged user).  All capabilities are available
> (LL_CAPS is not set), but namespace creation is still restricted to the
> types listed in LL_NS.  The first command succeeds because user and UTS
> types are in the allowed set, and sets the hostname inside the new UTS
> namespace.  The second command fails because the network namespace type
> is not allowed by the LANDLOCK_PERM_NAMESPACE_ENTER rule:
> 
>   LL_FS_RO=/ LL_FS_RW=/proc LL_NS="user:uts" \
>     ./sandboxer /bin/sh -c \
>     "unshare --user --uts --map-root-user hostname sandbox \
>     && ! unshare --user --net true"
> 
> Allow only user namespace creation and CAP_SYS_CHROOT (18), denying all
> other capabilities and namespace types (works as an unprivileged user).
> An unprivileged process creates a user namespace (no capability
> required) and calls chroot inside it using the CAP_SYS_CHROOT granted
> within the new namespace:
> 
>   LL_FS_RO=/ LL_FS_RW="" LL_NS="user" LL_CAPS="18" \
>     ./sandboxer /bin/sh -c \
>     "unshare --user --keep-caps chroot / true"
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  samples/landlock/sandboxer.c | 164 +++++++++++++++++++++++++++++++++--
>  1 file changed, 155 insertions(+), 9 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 9f21088c0855..09c499703835 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -14,6 +14,8 @@
>  #include <fcntl.h>
>  #include <linux/landlock.h>
>  #include <linux/socket.h>
> +#include <sched.h>
> +#include <stdbool.h>
>  #include <stddef.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -22,12 +24,16 @@
>  #include <sys/stat.h>
>  #include <sys/syscall.h>
>  #include <unistd.h>
> -#include <stdbool.h>
>  
>  #if defined(__GLIBC__)
>  #include <linux/prctl.h>
>  #endif
>  
> +/* From include/linux/bits.h, not available in userspace. */
> +#ifndef BITS_PER_TYPE
> +#define BITS_PER_TYPE(type) (sizeof(type) * 8)
> +#endif
> +
>  #ifndef landlock_create_ruleset
>  static inline int
>  landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
> @@ -60,6 +66,8 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>  #define ENV_FS_RW_NAME "LL_FS_RW"
>  #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>  #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
> +#define ENV_CAPS_NAME "LL_CAPS"
> +#define ENV_NS_NAME "LL_NS"
>  #define ENV_SCOPED_NAME "LL_SCOPED"
>  #define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
>  #define ENV_DELIMITER ":"
> @@ -226,11 +234,125 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>  	return ret;
>  }
>  
> +static __u64 str2ns(const char *const name)
> +{
> +	static const struct {
> +		const char *name;
> +		__u64 value;
> +	} ns_map[] = {
> +		/* clang-format off */
> +		{ "cgroup",	CLONE_NEWCGROUP },
> +		{ "ipc",	CLONE_NEWIPC },
> +		{ "mnt",	CLONE_NEWNS },
> +		{ "net",	CLONE_NEWNET },
> +		{ "pid",	CLONE_NEWPID },
> +		{ "time",	CLONE_NEWTIME },
> +		{ "user",	CLONE_NEWUSER },
> +		{ "uts",	CLONE_NEWUTS },
> +		/* clang-format on */
> +	};
> +	size_t i;
> +
> +	for (i = 0; i < sizeof(ns_map) / sizeof(ns_map[0]); i++) {
> +		if (strcmp(name, ns_map[i].name) == 0)
> +			return ns_map[i].value;
> +	}
> +	return 0;
> +}
> +
> +static int populate_ruleset_caps(const char *const env_var,
> +				 const int ruleset_fd)
> +{
> +	int ret = 1;
> +	char *env_cap_name, *env_cap_name_next, *strcap;
> +	struct landlock_capability_attr cap_attr = {
> +		.allowed_perm = LANDLOCK_PERM_CAPABILITY_USE,
> +	};
> +
> +	env_cap_name = getenv(env_var);
> +	if (!env_cap_name)
> +		return 0;
> +	env_cap_name = strdup(env_cap_name);
> +	unsetenv(env_var);
> +
> +	env_cap_name_next = env_cap_name;
> +	while ((strcap = strsep(&env_cap_name_next, ENV_DELIMITER))) {
> +		__u64 cap;
> +
> +		if (strcmp(strcap, "") == 0)
> +			continue;
> +
> +		if (str2num(strcap, &cap) ||

libcap has cap_from_name(3).  I believe we are linking with libcap
already to drop them before tests.  (I have not used this function
myself yet, but it sounds like it would address this case.)


> +		    cap >= BITS_PER_TYPE(cap_attr.capabilities)) {
> +			fprintf(stderr,
> +				"Failed to parse capability at \"%s\"\n",
> +				strcap);
> +			goto out_free_name;
> +		}
> +		cap_attr.capabilities = 1ULL << cap;
> +		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_CAPABILITY,
> +				      &cap_attr, 0)) {
> +			fprintf(stderr,
> +				"Failed to update the ruleset with capability \"%llu\": %s\n",
> +				(unsigned long long)cap, strerror(errno));
> +			goto out_free_name;
> +		}
> +	}
> +	ret = 0;
> +
> +out_free_name:
> +	free(env_cap_name);
> +	return ret;
> +}
> +
> +static int populate_ruleset_ns(const char *const env_var, const int ruleset_fd)
> +{
> +	int ret = 1;
> +	char *env_ns_name, *env_ns_name_next, *strns;
> +	struct landlock_namespace_attr ns_attr = {
> +		.allowed_perm = LANDLOCK_PERM_NAMESPACE_ENTER,
> +	};
> +
> +	env_ns_name = getenv(env_var);
> +	if (!env_ns_name)
> +		return 0;
> +	env_ns_name = strdup(env_ns_name);
> +	unsetenv(env_var);
> +
> +	env_ns_name_next = env_ns_name;
> +	while ((strns = strsep(&env_ns_name_next, ENV_DELIMITER))) {
> +		__u64 ns_type;
> +
> +		if (strcmp(strns, "") == 0)
> +			continue;
> +
> +		ns_type = str2ns(strns);
> +		if (!ns_type) {
> +			fprintf(stderr, "Unknown namespace type \"%s\"\n",
> +				strns);
> +			goto out_free_name;
> +		}
> +		ns_attr.namespace_types = ns_type;
> +		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NAMESPACE,
> +				      &ns_attr, 0)) {
> +			fprintf(stderr,
> +				"Failed to update the ruleset with namespace \"%s\": %s\n",
> +				strns, strerror(errno));
> +			goto out_free_name;
> +		}
> +	}
> +	ret = 0;
> +
> +out_free_name:
> +	free(env_ns_name);
> +	return ret;
> +}
> +
>  /* Returns true on error, false otherwise. */
>  static bool check_ruleset_scope(const char *const env_var,
>  				struct landlock_ruleset_attr *ruleset_attr)
>  {
> -	char *env_type_scope, *env_type_scope_next, *ipc_scoping_name;
> +	char *env_type_scope, *env_type_scope_next, *scope_name;
>  	bool error = false;
>  	bool abstract_scoping = false;
>  	bool signal_scoping = false;
> @@ -247,16 +369,14 @@ static bool check_ruleset_scope(const char *const env_var,
>  
>  	env_type_scope = strdup(env_type_scope);
>  	env_type_scope_next = env_type_scope;
> -	while ((ipc_scoping_name =
> -			strsep(&env_type_scope_next, ENV_DELIMITER))) {
> -		if (strcmp("a", ipc_scoping_name) == 0 && !abstract_scoping) {
> +	while ((scope_name = strsep(&env_type_scope_next, ENV_DELIMITER))) {
> +		if (strcmp("a", scope_name) == 0 && !abstract_scoping) {
>  			abstract_scoping = true;
> -		} else if (strcmp("s", ipc_scoping_name) == 0 &&
> -			   !signal_scoping) {
> +		} else if (strcmp("s", scope_name) == 0 && !signal_scoping) {
>  			signal_scoping = true;
>  		} else {
>  			fprintf(stderr, "Unknown or duplicate scope \"%s\"\n",
> -				ipc_scoping_name);
> +				scope_name);
>  			error = true;
>  			goto out_free_name;
>  		}
> @@ -299,7 +419,7 @@ static bool check_ruleset_scope(const char *const env_var,
>  
>  /* clang-format on */
>  
> -#define LANDLOCK_ABI_LAST 8
> +#define LANDLOCK_ABI_LAST 9
>  
>  #define XSTR(s) #s
>  #define STR(s) XSTR(s)
> @@ -322,6 +442,10 @@ static const char help[] =
>  	"means an empty list):\n"
>  	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
>  	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
> +	"* " ENV_CAPS_NAME ": capability numbers allowed to use "
> +	"(e.g. 10 for CAP_NET_BIND_SERVICE, 21 for CAP_SYS_ADMIN)\n"
> +	"* " ENV_NS_NAME ": namespace types allowed to enter "
> +	"(cgroup, ipc, mnt, net, pid, time, user, uts)\n"
>  	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
>  	"  - \"a\" to restrict opening abstract unix sockets\n"
>  	"  - \"s\" to restrict sending signals\n"
> @@ -334,6 +458,8 @@ static const char help[] =
>  	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>  	ENV_TCP_BIND_NAME "=\"9418\" "
>  	ENV_TCP_CONNECT_NAME "=\"80:443\" "
> +	ENV_CAPS_NAME "=\"21\" "
> +	ENV_NS_NAME "=\"user:uts:net\" "
>  	ENV_SCOPED_NAME "=\"a:s\" "
>  	"%1$s bash -i\n"
>  	"\n"
> @@ -357,6 +483,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
>  		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>  			  LANDLOCK_SCOPE_SIGNAL,
> +		.handled_perm = LANDLOCK_PERM_CAPABILITY_USE |
> +				LANDLOCK_PERM_NAMESPACE_ENTER,
>  	};
>  	int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
>  	int set_restrict_flags = 0;
> @@ -438,6 +566,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  			~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
>  		__attribute__((fallthrough));
>  	case 7:
> +		__attribute__((fallthrough));
> +	case 8:
> +		/* Removes permission support for ABI < 9 */
> +		ruleset_attr.handled_perm = 0;
>  		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
>  		fprintf(stderr,
>  			"Hint: You should update the running kernel "
> @@ -470,6 +602,14 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
>  	}
>  
> +	/* Removes capability handling if not set by a user. */
> +	if (!getenv(ENV_CAPS_NAME))
> +		ruleset_attr.handled_perm &= ~LANDLOCK_PERM_CAPABILITY_USE;
> +
> +	/* Removes namespace handling if not set by a user. */
> +	if (!getenv(ENV_NS_NAME))
> +		ruleset_attr.handled_perm &= ~LANDLOCK_PERM_NAMESPACE_ENTER;
> +
>  	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
>  		return 1;
>  
> @@ -514,6 +654,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
>  		goto err_close_ruleset;
>  	}
>  
> +	if (populate_ruleset_caps(ENV_CAPS_NAME, ruleset_fd))
> +		goto err_close_ruleset;
> +
> +	if (populate_ruleset_ns(ENV_NS_NAME, ruleset_fd))
> +		goto err_close_ruleset;
> +
>  	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>  		perror("Failed to restrict privileges");
>  		goto err_close_ruleset;
> -- 
> 2.53.0
> 
