Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CB38F65C
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236178; cv=none; b=L2kAUW4odf/LD5w4qNl/0NiG3t5izH5A31YKvTAcVMl+1WZfox1bNjyjq2KzJsL3I3FkOx7NrLJqtpkDCDPdMPBrK52O79bPBOVU1SmfrbO5qRqdpjdjIvUbBb84znSUAmfkDYCJ4P4yst5wDkPeIRwqgOlJG8GB73Ke4bCteII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236178; c=relaxed/simple;
	bh=bbQQwH9K3kuT9i56bIepUmHacSUfGNYp7tdfe/1c370=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffoAFnk077PJEDyEY9UuGkiQnHe3i3TSgrL5/3NQholphQNIBrI5cDpOgH3UkUYazDwbiSJ2XhwFjlgJmgtxLYf8eN+o5Ide5k3tOzDKQNykHJvqnVjX2ZrCjxmWJ+RL1xz6oGxzVbqCv4ra9NaWhJTrRabthh8JdV3yvAa1IGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=d9tzmljA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f73gPQr3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="d9tzmljA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f73gPQr3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45AAB140008D;
	Sun, 26 Apr 2026 16:42:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 26 Apr 2026 16:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777236174;
	 x=1777322574; bh=OweTGnbYZi4/42D9gTcwGt+PtjA2aRCRZb9uxLb0gcw=; b=
	d9tzmljAqMAH/QhNv0BXaztNj/VvcsyWKzaWs7VvDswaLOtCECxB9ZJlV1IgtwEr
	EJ03Am6pQoKErXrc0IegnZnNQKmldKAOHf7kR9Xs37SYs5VpGazilM+9RcHsZo1k
	JwLYTZC8b028XV736DU7PmLxt5quTkG7zW1cbQRmOfTqx5Te4+u0sBhE5naDNpVF
	BwtFW/Tn7Yl+RFNPtLn0AWEjc/nIfXvrP9M32C9QiqPEb9U9eU/aGBtp4babi/fM
	mkdcisGrqlSAeAKN9nJ0eH7yqLg1tuvL8cuvhN7726EIk2xU+bY10TdbKRnQQTgF
	hALfsbuJTgCd1pK8RDfEwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777236174; x=
	1777322574; bh=OweTGnbYZi4/42D9gTcwGt+PtjA2aRCRZb9uxLb0gcw=; b=f
	73gPQr3Z5IdFL9i17oG58/EW1ugTCTBl2JykNxuCQ8TL2g+zG7i9xyJ28FAE3AGG
	XicQ4fn515NSmS5nTyI0Iz02vqZHpxHd9TaduO42r/MTVMCcQ8p8L0lA1FhyuJVO
	YhHQsF+BwLhhhH6C4XbrHcIBDA1gTuKDpDCC2vpCiixvZpEh4BiXiV1fHFw1pIoI
	yWF3NaubMvvhlNMk/6oIm5QS3JUyFKy8T/ISja8kzEVXSDVCppbw9oy8xKx9dwUM
	41e3Nqv3qzu2Rm1PFJKEBnR6qTm7xBaQG0avLTATYNtXXKXauDShPNk5CAMoMrli
	X4Geci4EPXbdrvrlxuOFg==
X-ME-Sender: <xms:zXjuaWx6s8WVMovZe2u-VCO7dv8Mi6nprwIpUW5ZaF0b9O6HGZU5qg>
    <xme:zXjuabmX5dRfnc_EWuObJCqUfVcaLISZQSNPkVuePOBaME5U5B7bTZ6y0rOTt0Yss
    e5SZYa4XU_J5uKM4nJN75Stqu3tD2NtKkHpiqGlIiaQd27BJVquPA>
X-ME-Received: <xmr:zXjuafmeE595HilyVdgJu-ir16JVzG_eJ9GZzAYVoo2UGtxIO6tXtWJxrEUzW1XyrPP76cYrF1dgmoCEU1zDGmpMCVynPzSHeUGyPIicqNZULkKtDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejieejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephfdtudfhleeufffhtdetgeeggffhvedvieeftdelgeejudejhfeutedujeeg
    keetnecuffhomhgrihhnpehlrghunhgthhhprggurdhnvghtnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdr
    tghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggrlhesghhomhhp
    rgdruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhope
    hfuhhsvgdquggvvhgvlheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:zXjuadyE6maZtiqi3Pn-XnBK2bR3_eRDzhbX8s_hfBLSVl65gDz7tg>
    <xmx:zXjuaUqwENYcbmyt5YmP4AI7qb_iXmMNXERJtMTGBsoM_WbN4URZaA>
    <xmx:zXjuac6Pg9IJ7Zd6NO90KhjnJj-Pivic-OXrhdynbs3gvI5Lha7OOA>
    <xmx:zXjuabcqY_YBVeEavah9tuuNttitujbFfBwcYUiXDohs4R553FjUWw>
    <xmx:znjuaaJ5g8Ua0cPTmqt5Tt92nxE25lEsd6xuSgyMNvskZlsL7CFzi7at>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 16:42:52 -0400 (EDT)
Message-ID: <dc82e3b8-09ee-4681-932f-2948d8e9a021@bsbernd.com>
Date: Sun, 26 Apr 2026 22:42:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] util: hoist the fuse.conf parsing and setuid mode
 enforcement code
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
 miklos@szeredi.hu, fuse-devel@lists.linux.dev
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
 <177689988649.3820166.3224389906885819847.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <177689988649.3820166.3224389906885819847.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/26 01:20, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Move all the code that parses fuse.conf into a separate file in util/ so
> that fuservicemount can read the same file, then add the security checks
> that occur when fusermount is trying to start up a filesystem but is not
> running as root.  We'll want that for fusermount in a moment.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  util/fuser_conf.h |   61 ++++++++
>  util/fuser_conf.c |  381 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  util/fusermount.c |  358 +-------------------------------------------------
>  util/meson.build  |    6 -
>  4 files changed, 453 insertions(+), 353 deletions(-)
>  create mode 100644 util/fuser_conf.h
>  create mode 100644 util/fuser_conf.c
> 
> 
> diff --git a/util/fuser_conf.h b/util/fuser_conf.h
> new file mode 100644
> index 00000000000000..5afe70709c5152
> --- /dev/null
> +++ b/util/fuser_conf.h
> @@ -0,0 +1,61 @@
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> + *
> + * This program can be distributed under the terms of the GNU LGPLv2.
> + * See the file LGPL2.txt.
> + */
> +#ifndef FUSER_CONF_H_
> +#define FUSER_CONF_H_
> +
> +#include <sys/vfs.h>
> +#include <sys/stat.h>
> +
> +extern int user_allow_other;
> +extern int mount_max;
> +
> +void unescape(char *buf);
> +
> +#ifdef GETMNTENT_NEEDS_UNESCAPING
> +#include <stdio.h>
> +#include <mntent.h>
> +
> +static inline struct mntent *GETMNTENT(FILE *stream)
> +{
> +	struct mntent *entp = getmntent(stream);
> +	if(entp != NULL) {
> +		unescape(entp->mnt_fsname);
> +		unescape(entp->mnt_dir);
> +		unescape(entp->mnt_type);
> +		unescape(entp->mnt_opts);
> +	}
> +	return entp;
> +}
> +#else
> +#define GETMNTENT getmntent
> +#endif // GETMNTENT_NEEDS_UNESCAPING
> +
> +int count_fuse_fs(const char *progname);
> +
> +void read_conf(const char *progname);
> +
> +void drop_privs(void);
> +void restore_privs(void);
> +
> +int check_nonroot_mount_count(const char *progname);
> +
> +int check_nonroot_dir_access(const char *progname, const char *origmnt,
> +			     const char *mnt, const struct stat *stbuf);
> +
> +int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf);
> +
> +struct mount_flags {
> +	const char *opt;
> +	unsigned long flag;
> +	int on;
> +	int safe;
> +};
> +
> +extern const struct mount_flags mount_flags[];
> +
> +#endif /* FUSER_CONF_H_ */
> diff --git a/util/fuser_conf.c b/util/fuser_conf.c
> new file mode 100644
> index 00000000000000..dd60afaad31a0f
> --- /dev/null
> +++ b/util/fuser_conf.c
> @@ -0,0 +1,381 @@
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> + *
> + * This program can be distributed under the terms of the GNU GPLv2.
> + * See the file GPL2.txt.
> + */
> +/* This program parses fuse.conf */
> +#define _GNU_SOURCE
> +#include "fuse_config.h"
> +#include "mount_util.h"
> +#include "util.h"
> +#include "fuser_conf.h"

#include "fuse_mount_compat.h"

otherwise fails to compile

etc/fuse.conf"' -MD -MQ util/fusermount3.p/fuser_conf.c.o -MF
util/fusermount3.p/fuser_conf.c.o.d -o util/fusermount3.p/fuser_conf.c.o
-c ../util/fuser_conf.c
../util/fuser_conf.c:357:13: error: use of undeclared identifier 'MS_RDONLY'
  357 |         {"rw",      MS_RDONLY,      0, 1},
      |                     ^
../util/fuser_conf.c:358:13: error: use of undeclared identifier 'MS_RDONLY'
  358 |         {"ro",      MS_RDONLY,      1, 1},


> +
> +#include <string.h>
> +#include <stddef.h>
> +#include <ctype.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <mntent.h>
> +#include <unistd.h>
> +#include <sys/fsuid.h>
> +
> +#if defined HAVE_LISTMOUNT
> +#include <linux/mount.h>
> +#include <syscall.h>
> +#include <stdint.h>
> +#endif
> +
> +int user_allow_other = 0;
> +int mount_max = 1000;
> +static uid_t oldfsuid;
> +static gid_t oldfsgid;
> +
> +// Older versions of musl libc don't unescape entries in /etc/mtab
> +
> +// unescapes octal sequences like \040 in-place
> +// That's ok, because unescaping can not extend the length of the string.
> +void unescape(char *buf)
> +{
> +	char *src = buf;
> +	char *dest = buf;
> +	while (1) {
> +		char *next_src = strchrnul(src, '\\');
> +		int offset = next_src - src;
> +		memmove(dest, src, offset);
> +		src = next_src;
> +		dest += offset;
> +
> +		if(*src == '\0') {
> +			*dest = *src;
> +			return;
> +		}
> +		src++;
> +
> +		if('0' <= src[0] && src[0] < '2' &&
> +		   '0' <= src[1] && src[1] < '8' &&
> +		   '0' <= src[2] && src[2] < '8') {
> +			*dest++ = (src[0] - '0') << 6
> +			        | (src[1] - '0') << 3
> +			        | (src[2] - '0') << 0;
> +			src += 3;
> +		} else if (src[0] == '\\') {
> +			*dest++ = '\\';
> +			src += 1;
> +		} else {
> +			*dest++ = '\\';
> +		}
> +	}
> +}
> +
> +#ifndef IGNORE_MTAB
> +static int count_fuse_fs_mtab(const char *progname)
> +{
> +	const struct mntent *entp;
> +	int count = 0;
> +	const char *mtab = _PATH_MOUNTED;
> +	FILE *fp = setmntent(mtab, "r");
> +	if (fp == NULL) {
> +		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
> +			strerror(errno));
> +		return -1;
> +	}
> +	while ((entp = GETMNTENT(fp)) != NULL) {
> +		if (strcmp(entp->mnt_type, "fuse") == 0 ||
> +		    strncmp(entp->mnt_type, "fuse.", 5) == 0)
> +			count ++;
> +	}
> +	endmntent(fp);
> +	return count;
> +}
> +
> +#ifdef HAVE_LISTMOUNT
> +static int count_fuse_fs_ls_mnt(const char *progname)
> +{
> +	#define SMBUF_SIZE 1024
> +	#define MNT_ID_LEN 128
> +
> +	int fuse_count = 0;
> +	int n_mounts = 0;
> +	int ret = 0;
> +	uint64_t mnt_ids[MNT_ID_LEN];
> +	unsigned char smbuf[SMBUF_SIZE];
> +	struct mnt_id_req req = {
> +		.size = sizeof(struct mnt_id_req),
> +	};
> +	struct statmount *sm;
> +
> +	for (;;) {
> +		req.mnt_id = LSMT_ROOT;
> +
> +		n_mounts = syscall(SYS_listmount, &req, &mnt_ids, MNT_ID_LEN, 0);
> +		if (n_mounts == -1) {
> +			if (errno != ENOSYS) {
> +				fprintf(stderr, "%s: failed to list mounts: %s\n", progname,
> +					strerror(errno));
> +			}
> +			return -1;
> +		}
> +
> +		for (int i = 0; i < n_mounts; i++) {
> +			req.mnt_id = mnt_ids[i];
> +			req.param = STATMOUNT_FS_TYPE;
> +			ret = syscall(SYS_statmount, &req, &smbuf, SMBUF_SIZE, 0);
> +			if (ret) {
> +				if (errno == ENOENT)
> +					continue;
> +
> +				fprintf(stderr, "%s: failed to stat mount %lld: %s\n", progname,
> +					req.mnt_id, strerror(errno));
> +				return -1;
> +			}
> +
> +			sm = (struct statmount *)smbuf;
> +			if (sm->mask & STATMOUNT_FS_TYPE &&
> +			    strcmp(&sm->str[sm->fs_type], "fuse") == 0)
> +				fuse_count++;
> +		}
> +
> +		if (n_mounts < MNT_ID_LEN)
> +			break;
> +		req.param = mnt_ids[MNT_ID_LEN - 1];
> +	}
> +	return fuse_count;
> +}
> +
> +int count_fuse_fs(const char *progname)
> +{
> +	int count = count_fuse_fs_ls_mnt(progname);
> +
> +	return count >= 0 ? count : count_fuse_fs_mtab(progname);
> +}
> +#else
> +int count_fuse_fs(const char *progname)
> +{
> +	return count_fuse_fs_mtab(progname);
> +}
> +#endif /* HAVE_LISTMOUNT */
> +#else
> +int count_fuse_fs(const char *progname)
> +{
> +	return 0;
> +}
> +#endif /* !IGNORE_MTAB */
> +
> +static void strip_line(char *line)
> +{
> +	char *s = strchr(line, '#');
> +	if (s != NULL)
> +		s[0] = '\0';
> +	for (s = line + strlen(line) - 1;
> +	     s >= line && isspace((unsigned char) *s); s--);
> +	s[1] = '\0';
> +	for (s = line; isspace((unsigned char) *s); s++);
> +	if (s != line)
> +		memmove(line, s, strlen(s)+1);
> +}
> +
> +static void parse_line(const char *line, int linenum, const char *progname)
> +{
> +	int tmp;
> +	if (strcmp(line, "user_allow_other") == 0)
> +		user_allow_other = 1;
> +	else if (sscanf(line, "mount_max = %i", &tmp) == 1)
> +		mount_max = tmp;
> +	else if(line[0])
> +		fprintf(stderr,
> +			"%s: unknown parameter in %s at line %i: '%s'\n",
> +			progname, FUSE_CONF, linenum, line);
> +}
> +
> +void read_conf(const char *progname)
> +{
> +	FILE *fp = fopen(FUSE_CONF, "r");
> +	if (fp != NULL) {
> +		int linenum = 1;
> +		char line[256];
> +		int isnewline = 1;
> +		while (fgets(line, sizeof(line), fp) != NULL) {
> +			if (isnewline) {
> +				if (line[strlen(line)-1] == '\n') {
> +					strip_line(line);
> +					parse_line(line, linenum, progname);
> +				} else {
> +					isnewline = 0;
> +				}
> +			} else if(line[strlen(line)-1] == '\n') {
> +				fprintf(stderr, "%s: reading %s: line %i too long\n", progname, FUSE_CONF, linenum);
> +
> +				isnewline = 1;
> +			}
> +			if (isnewline)
> +				linenum ++;
> +		}
> +		if (!isnewline) {
> +			fprintf(stderr, "%s: reading %s: missing newline at end of file\n", progname, FUSE_CONF);
> +
> +		}
> +		if (ferror(fp)) {
> +			fprintf(stderr, "%s: reading %s: read failed\n", progname, FUSE_CONF);
> +			exit(1);
> +		}
> +		fclose(fp);
> +	} else if (errno != ENOENT) {
> +		bool fatal = (errno != EACCES && errno != ELOOP &&
> +			      errno != ENAMETOOLONG && errno != ENOTDIR &&
> +			      errno != EOVERFLOW);
> +		fprintf(stderr, "%s: failed to open %s: %s\n",
> +			progname, FUSE_CONF, strerror(errno));
> +		if (fatal)
> +			exit(1);
> +	}
> +}
> +
> +void drop_privs(void)
> +{
> +	if (getuid() != 0) {
> +		oldfsuid = setfsuid(getuid());
> +		oldfsgid = setfsgid(getgid());
> +	}
> +}
> +
> +void restore_privs(void)
> +{
> +	if (getuid() != 0) {
> +		setfsuid(oldfsuid);
> +		setfsgid(oldfsgid);
> +	}
> +}
> +
> +int check_nonroot_mount_count(const char *progname)
> +{
> +	if (mount_max == -1)
> +		return 0;
> +
> +	int mount_count = count_fuse_fs(progname);
> +
> +	if (mount_count >= mount_max) {
> +		fprintf(stderr,
> +"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
> +			progname, FUSE_CONF);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int check_nonroot_dir_access(const char *progname, const char *origmnt,
> +			     const char *mnt, const struct stat *stbuf)
> +{
> +	int res;
> +
> +	if ((stbuf->st_mode & S_ISVTX) && stbuf->st_uid != getuid()) {
> +		fprintf(stderr, "%s: mountpoint %s not owned by user\n",
> +			progname, origmnt);
> +		return -1;
> +	}
> +
> +	res = access(mnt, W_OK);
> +	if (res == -1) {
> +		fprintf(stderr, "%s: user has no write access to mountpoint %s\n",
> +			progname, origmnt);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
> +{
> +	size_t i;
> +
> +	/* Do not permit mounting over anything in procfs - it has a couple
> +	 * places to which we have "write access" without being supposed to be
> +	 * able to just put anything we want there.
> +	 * Luckily, without allow_other, we can't get other users to actually
> +	 * use any fake information we try to put there anyway.
> +	 * Use a whitelist to be safe. */
> +
> +	/* Define permitted filesystems for the mount target. This was
> +	 * originally the same list as used by the ecryptfs mount helper
> +	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
> +	 * but got expanded as we found more filesystems that needed to be
> +	 * overlaid. */
> +	typeof(fs_buf->f_type) f_type_whitelist[] = {
> +		0x61756673 /* AUFS_SUPER_MAGIC */,
> +		0x00000187 /* AUTOFS_SUPER_MAGIC */,
> +		0xCA451A4E /* BCACHEFS_STATFS_MAGIC */,
> +		0x9123683E /* BTRFS_SUPER_MAGIC */,
> +		0x00C36400 /* CEPH_SUPER_MAGIC */,
> +		0xFF534D42 /* CIFS_MAGIC_NUMBER */,
> +		0x0000F15F /* ECRYPTFS_SUPER_MAGIC */,
> +		0X2011BAB0 /* EXFAT_SUPER_MAGIC */,
> +		0x0000EF53 /* EXT[234]_SUPER_MAGIC */,
> +		0xF2F52010 /* F2FS_SUPER_MAGIC */,
> +		0x65735546 /* FUSE_SUPER_MAGIC */,
> +		0x01161970 /* GFS2_MAGIC */,
> +		0x47504653 /* GPFS_SUPER_MAGIC */,
> +		0x0000482b /* HFSPLUS_SUPER_MAGIC */,
> +		0x000072B6 /* JFFS2_SUPER_MAGIC */,
> +		0x3153464A /* JFS_SUPER_MAGIC */,
> +		0x0BD00BD0 /* LL_SUPER_MAGIC */,
> +		0X00004D44 /* MSDOS_SUPER_MAGIC */,
> +		0x0000564C /* NCP_SUPER_MAGIC */,
> +		0x00006969 /* NFS_SUPER_MAGIC */,
> +		0x00003434 /* NILFS_SUPER_MAGIC */,
> +		0x5346544E /* NTFS_SB_MAGIC */,
> +		0x7366746E /* NTFS3_SUPER_MAGIC */,
> +		0x5346414f /* OPENAFS_SUPER_MAGIC */,
> +		0x794C7630 /* OVERLAYFS_SUPER_MAGIC */,
> +		0xAAD7AAEA /* PANFS_SUPER_MAGIC */,
> +		0x52654973 /* REISERFS_SUPER_MAGIC */,
> +		0xFE534D42 /* SMB2_SUPER_MAGIC */,
> +		0x73717368 /* SQUASHFS_MAGIC */,
> +		0x01021994 /* TMPFS_MAGIC */,
> +		0x24051905 /* UBIFS_SUPER_MAGIC */,
> +		0x18031977 /* WEKAFS_SUPER_MAGIC */,
> +#if __SIZEOF_LONG__ > 4
> +		0x736675005346544e /* UFSD */,
> +#endif
> +		0x58465342 /* XFS_SB_MAGIC */,
> +		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
> +		0x858458f6 /* RAMFS_MAGIC */,
> +	};
> +	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
> +		if (f_type_whitelist[i] == fs_buf->f_type)
> +			return 0;
> +	}
> +
> +	fprintf(stderr, "%s: mounting over filesystem type %#010lx is forbidden\n",
> +		progname, (unsigned long)fs_buf->f_type);
> +	return -1;
> +}
> +
> +const struct mount_flags mount_flags[] = {
> +	{"rw",	    MS_RDONLY,	    0, 1},
> +	{"ro",	    MS_RDONLY,	    1, 1},
> +	{"suid",    MS_NOSUID,	    0, 0},
> +	{"nosuid",  MS_NOSUID,	    1, 1},
> +	{"dev",	    MS_NODEV,	    0, 0},
> +	{"nodev",   MS_NODEV,	    1, 1},
> +	{"exec",    MS_NOEXEC,	    0, 1},
> +	{"noexec",  MS_NOEXEC,	    1, 1},
> +	{"async",   MS_SYNCHRONOUS, 0, 1},
> +	{"sync",    MS_SYNCHRONOUS, 1, 1},
> +	{"atime",   MS_NOATIME,	    0, 1},
> +	{"noatime", MS_NOATIME,	    1, 1},
> +	{"diratime",        MS_NODIRATIME,  0, 1},
> +	{"nodiratime",      MS_NODIRATIME,  1, 1},
> +	{"lazytime",        MS_LAZYTIME,    1, 1},
> +	{"nolazytime",      MS_LAZYTIME,    0, 1},
> +	{"relatime",        MS_RELATIME,    1, 1},
> +	{"norelatime",      MS_RELATIME,    0, 1},
> +	{"strictatime",     MS_STRICTATIME, 1, 1},
> +	{"nostrictatime",   MS_STRICTATIME, 0, 1},
> +	{"dirsync", MS_DIRSYNC,	    1, 1},
> +	{"symfollow",       MS_NOSYMFOLLOW, 0, 1},
> +	{"nosymfollow",     MS_NOSYMFOLLOW, 1, 1},
> +	{NULL,	    0,		    0, 0}
> +};
> diff --git a/util/fusermount.c b/util/fusermount.c
> index 68370468140a59..c7905d58a85e32 100644
> --- a/util/fusermount.c
> +++ b/util/fusermount.c
> @@ -11,6 +11,7 @@
>  #include "fuse_config.h"
>  #include "mount_util.h"
>  #include "util.h"
> +#include "fuser_conf.h"
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -50,63 +51,8 @@
>  
>  static const char *progname;
>  
> -static int user_allow_other = 0;
> -static int mount_max = 1000;
> -
>  static int auto_unmount = 0;
>  
> -#ifdef GETMNTENT_NEEDS_UNESCAPING
> -// Older versions of musl libc don't unescape entries in /etc/mtab
> -
> -// unescapes octal sequences like \040 in-place
> -// That's ok, because unescaping can not extend the length of the string.
> -static void unescape(char *buf) {
> -	char *src = buf;
> -	char *dest = buf;
> -	while (1) {
> -		char *next_src = strchrnul(src, '\\');
> -		int offset = next_src - src;
> -		memmove(dest, src, offset);
> -		src = next_src;
> -		dest += offset;
> -
> -		if(*src == '\0') {
> -			*dest = *src;
> -			return;
> -		}
> -		src++;
> -
> -		if('0' <= src[0] && src[0] < '2' &&
> -		   '0' <= src[1] && src[1] < '8' &&
> -		   '0' <= src[2] && src[2] < '8') {
> -			*dest++ = (src[0] - '0') << 6
> -			        | (src[1] - '0') << 3
> -			        | (src[2] - '0') << 0;
> -			src += 3;
> -		} else if (src[0] == '\\') {
> -			*dest++ = '\\';
> -			src += 1;
> -		} else {
> -			*dest++ = '\\';
> -		}
> -	}
> -}
> -
> -static struct mntent *GETMNTENT(FILE *stream)
> -{
> -	struct mntent *entp = getmntent(stream);
> -	if(entp != NULL) {
> -		unescape(entp->mnt_fsname);
> -		unescape(entp->mnt_dir);
> -		unescape(entp->mnt_type);
> -		unescape(entp->mnt_opts);
> -	}
> -	return entp;
> -}
> -#else
> -#define GETMNTENT getmntent
> -#endif // GETMNTENT_NEEDS_UNESCAPING
> -
>  /*
>   * Take a ',' separated option string and extract "x-" options
>   */
> @@ -188,25 +134,6 @@ static const char *get_user_name(void)
>  	}
>  }
>  
> -static uid_t oldfsuid;
> -static gid_t oldfsgid;
> -
> -static void drop_privs(void)
> -{
> -	if (getuid() != 0) {
> -		oldfsuid = setfsuid(getuid());
> -		oldfsgid = setfsgid(getgid());
> -	}
> -}
> -
> -static void restore_privs(void)
> -{
> -	if (getuid() != 0) {
> -		setfsuid(oldfsuid);
> -		setfsgid(oldfsgid);
> -	}
> -}
> -
>  #ifndef IGNORE_MTAB
>  /*
>   * Make sure that /etc/mtab is checked and updated atomically
> @@ -568,100 +495,7 @@ static int unmount_fuse(const char *mnt, int quiet, int lazy)
>  
>  	return res;
>  }
> -
> -static int count_fuse_fs_mtab(void)
> -{
> -	const struct mntent *entp;
> -	int count = 0;
> -	const char *mtab = _PATH_MOUNTED;
> -	FILE *fp = setmntent(mtab, "r");
> -	if (fp == NULL) {
> -		fprintf(stderr, "%s: failed to open %s: %s\n", progname, mtab,
> -			strerror(errno));
> -		return -1;
> -	}
> -	while ((entp = GETMNTENT(fp)) != NULL) {
> -		if (strcmp(entp->mnt_type, "fuse") == 0 ||
> -		    strncmp(entp->mnt_type, "fuse.", 5) == 0)
> -			count ++;
> -	}
> -	endmntent(fp);
> -	return count;
> -}
> -
> -#ifdef HAVE_LISTMOUNT
> -static int count_fuse_fs_ls_mnt(void)
> -{
> -	#define SMBUF_SIZE 1024
> -	#define MNT_ID_LEN 128
> -
> -	int fuse_count = 0;
> -	int n_mounts = 0;
> -	int ret = 0;
> -	uint64_t mnt_ids[MNT_ID_LEN];
> -	unsigned char smbuf[SMBUF_SIZE];
> -	struct mnt_id_req req = {
> -		.size = sizeof(struct mnt_id_req),
> -	};
> -	struct statmount *sm;
> -
> -	for (;;) {
> -		req.mnt_id = LSMT_ROOT;
> -
> -		n_mounts = syscall(SYS_listmount, &req, &mnt_ids, MNT_ID_LEN, 0);
> -		if (n_mounts == -1) {
> -			if (errno != ENOSYS) {
> -				fprintf(stderr, "%s: failed to list mounts: %s\n", progname,
> -					strerror(errno));
> -			}
> -			return -1;
> -		}
> -
> -		for (int i = 0; i < n_mounts; i++) {
> -			req.mnt_id = mnt_ids[i];
> -			req.param = STATMOUNT_FS_TYPE;
> -			ret = syscall(SYS_statmount, &req, &smbuf, SMBUF_SIZE, 0);
> -			if (ret) {
> -				if (errno == ENOENT)
> -					continue;
> -
> -				fprintf(stderr, "%s: failed to stat mount %lld: %s\n", progname,
> -					req.mnt_id, strerror(errno));
> -				return -1;
> -			}
> -
> -			sm = (struct statmount *)smbuf;
> -			if (sm->mask & STATMOUNT_FS_TYPE &&
> -			    strcmp(&sm->str[sm->fs_type], "fuse") == 0)
> -				fuse_count++;
> -		}
> -
> -		if (n_mounts < MNT_ID_LEN)
> -			break;
> -		req.param = mnt_ids[MNT_ID_LEN - 1];
> -	}
> -	return fuse_count;
> -}
> -
> -static int count_fuse_fs(void)
> -{
> -	int count = count_fuse_fs_ls_mnt();
> -
> -	return count >= 0 ? count : count_fuse_fs_mtab();
> -}
> -#else
> -static int count_fuse_fs(void)
> -{
> -	return count_fuse_fs_mtab();
> -}
> -#endif
> -
>  #else /* IGNORE_MTAB */
> -static int count_fuse_fs(void)
> -{
> -	return 0;
> -}
> -
>  static int add_mount(const char *source, const char *mnt, const char *type,
>  		     const char *opts)
>  {
> @@ -679,75 +513,6 @@ static int unmount_fuse(const char *mnt, int quiet, int lazy)
>  }
>  #endif /* IGNORE_MTAB */
>  
> -static void strip_line(char *line)
> -{
> -	char *s = strchr(line, '#');
> -	if (s != NULL)
> -		s[0] = '\0';
> -	for (s = line + strlen(line) - 1;
> -	     s >= line && isspace((unsigned char) *s); s--);
> -	s[1] = '\0';
> -	for (s = line; isspace((unsigned char) *s); s++);
> -	if (s != line)
> -		memmove(line, s, strlen(s)+1);
> -}
> -
> -static void parse_line(const char *line, int linenum)
> -{
> -	int tmp;
> -	if (strcmp(line, "user_allow_other") == 0)
> -		user_allow_other = 1;
> -	else if (sscanf(line, "mount_max = %i", &tmp) == 1)
> -		mount_max = tmp;
> -	else if(line[0])
> -		fprintf(stderr,
> -			"%s: unknown parameter in %s at line %i: '%s'\n",
> -			progname, FUSE_CONF, linenum, line);
> -}
> -
> -static void read_conf(void)
> -{
> -	FILE *fp = fopen(FUSE_CONF, "r");
> -	if (fp != NULL) {
> -		int linenum = 1;
> -		char line[256];
> -		int isnewline = 1;
> -		while (fgets(line, sizeof(line), fp) != NULL) {
> -			if (isnewline) {
> -				if (line[strlen(line)-1] == '\n') {
> -					strip_line(line);
> -					parse_line(line, linenum);
> -				} else {
> -					isnewline = 0;
> -				}
> -			} else if(line[strlen(line)-1] == '\n') {
> -				fprintf(stderr, "%s: reading %s: line %i too long\n", progname, FUSE_CONF, linenum);
> -
> -				isnewline = 1;
> -			}
> -			if (isnewline)
> -				linenum ++;
> -		}
> -		if (!isnewline) {
> -			fprintf(stderr, "%s: reading %s: missing newline at end of file\n", progname, FUSE_CONF);
> -
> -		}
> -		if (ferror(fp)) {
> -			fprintf(stderr, "%s: reading %s: read failed\n", progname, FUSE_CONF);
> -			exit(1);
> -		}
> -		fclose(fp);
> -	} else if (errno != ENOENT) {
> -		bool fatal = (errno != EACCES && errno != ELOOP &&
> -			      errno != ENAMETOOLONG && errno != ENOTDIR &&
> -			      errno != EOVERFLOW);
> -		fprintf(stderr, "%s: failed to open %s: %s\n",
> -			progname, FUSE_CONF, strerror(errno));
> -		if (fatal)
> -			exit(1);
> -	}
> -}
> -
>  static int begins_with(const char *s, const char *beg)
>  {
>  	if (strncmp(s, beg, strlen(beg)) == 0)
> @@ -756,40 +521,6 @@ static int begins_with(const char *s, const char *beg)
>  		return 0;
>  }
>  
> -struct mount_flags {
> -	const char *opt;
> -	unsigned long flag;
> -	int on;
> -	int safe;
> -};
> -
> -static struct mount_flags mount_flags[] = {
> -	{"rw",	    MS_RDONLY,	    0, 1},
> -	{"ro",	    MS_RDONLY,	    1, 1},
> -	{"suid",    MS_NOSUID,	    0, 0},
> -	{"nosuid",  MS_NOSUID,	    1, 1},
> -	{"dev",	    MS_NODEV,	    0, 0},
> -	{"nodev",   MS_NODEV,	    1, 1},
> -	{"exec",    MS_NOEXEC,	    0, 1},
> -	{"noexec",  MS_NOEXEC,	    1, 1},
> -	{"async",   MS_SYNCHRONOUS, 0, 1},
> -	{"sync",    MS_SYNCHRONOUS, 1, 1},
> -	{"atime",   MS_NOATIME,	    0, 1},
> -	{"noatime", MS_NOATIME,	    1, 1},
> -	{"diratime",        MS_NODIRATIME,  0, 1},
> -	{"nodiratime",      MS_NODIRATIME,  1, 1},
> -	{"lazytime",        MS_LAZYTIME,    1, 1},
> -	{"nolazytime",      MS_LAZYTIME,    0, 1},
> -	{"relatime",        MS_RELATIME,    1, 1},
> -	{"norelatime",      MS_RELATIME,    0, 1},
> -	{"strictatime",     MS_STRICTATIME, 1, 1},
> -	{"nostrictatime",   MS_STRICTATIME, 0, 1},
> -	{"dirsync", MS_DIRSYNC,	    1, 1},
> -	{"symfollow",       MS_NOSYMFOLLOW, 0, 1},
> -	{"nosymfollow",     MS_NOSYMFOLLOW, 1, 1},
> -	{NULL,	    0,		    0, 0}
> -};
> -
>  static int find_mount_flag(const char *s, unsigned len, int *on, int *flag)
>  {
>  	int i;
> @@ -1096,7 +827,6 @@ static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
>  	const char *mnt = *mntp;
>  	const char *origmnt = mnt;
>  	struct statfs fs_buf;
> -	size_t i;
>  
>  	res = lstat(mnt, stbuf);
>  	if (res == -1) {
> @@ -1126,18 +856,9 @@ static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
>  			return -1;
>  		}
>  
> -		if ((stbuf->st_mode & S_ISVTX) && stbuf->st_uid != getuid()) {
> -			fprintf(stderr, "%s: mountpoint %s not owned by user\n",
> -				progname, origmnt);
> -			return -1;
> -		}
> -
> -		res = access(mnt, W_OK);
> -		if (res == -1) {
> -			fprintf(stderr, "%s: user has no write access to mountpoint %s\n",
> -				progname, origmnt);
> -			return -1;
> -		}
> +		res = check_nonroot_dir_access(progname, origmnt, mnt, stbuf);
> +		if (res)
> +			return res;
>  	} else if (S_ISREG(stbuf->st_mode)) {
>  		static char procfile[256];
>  		*mountpoint_fd = open(mnt, O_WRONLY);
> @@ -1169,71 +890,13 @@ static int check_perm(const char **mntp, struct stat *stbuf, int *mountpoint_fd)
>  		return -1;
>  	}
>  
> -	/* Do not permit mounting over anything in procfs - it has a couple
> -	 * places to which we have "write access" without being supposed to be
> -	 * able to just put anything we want there.
> -	 * Luckily, without allow_other, we can't get other users to actually
> -	 * use any fake information we try to put there anyway.
> -	 * Use a whitelist to be safe. */
>  	if (statfs(*mntp, &fs_buf)) {
>  		fprintf(stderr, "%s: failed to access mountpoint %s: %s\n",
>  			progname, mnt, strerror(errno));
>  		return -1;
>  	}
>  
> -	/* Define permitted filesystems for the mount target. This was
> -	 * originally the same list as used by the ecryptfs mount helper
> -	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
> -	 * but got expanded as we found more filesystems that needed to be
> -	 * overlaid. */
> -	typeof(fs_buf.f_type) f_type_whitelist[] = {
> -		0x61756673 /* AUFS_SUPER_MAGIC */,
> -		0x00000187 /* AUTOFS_SUPER_MAGIC */,
> -		0xCA451A4E /* BCACHEFS_STATFS_MAGIC */,
> -		0x9123683E /* BTRFS_SUPER_MAGIC */,
> -		0x00C36400 /* CEPH_SUPER_MAGIC */,
> -		0xFF534D42 /* CIFS_MAGIC_NUMBER */,
> -		0x0000F15F /* ECRYPTFS_SUPER_MAGIC */,
> -		0X2011BAB0 /* EXFAT_SUPER_MAGIC */,
> -		0x0000EF53 /* EXT[234]_SUPER_MAGIC */,
> -		0xF2F52010 /* F2FS_SUPER_MAGIC */,
> -		0x65735546 /* FUSE_SUPER_MAGIC */,
> -		0x01161970 /* GFS2_MAGIC */,
> -		0x47504653 /* GPFS_SUPER_MAGIC */,
> -		0x0000482b /* HFSPLUS_SUPER_MAGIC */,
> -		0x000072B6 /* JFFS2_SUPER_MAGIC */,
> -		0x3153464A /* JFS_SUPER_MAGIC */,
> -		0x0BD00BD0 /* LL_SUPER_MAGIC */,
> -		0X00004D44 /* MSDOS_SUPER_MAGIC */,
> -		0x0000564C /* NCP_SUPER_MAGIC */,
> -		0x00006969 /* NFS_SUPER_MAGIC */,
> -		0x00003434 /* NILFS_SUPER_MAGIC */,
> -		0x5346544E /* NTFS_SB_MAGIC */,
> -		0x7366746E /* NTFS3_SUPER_MAGIC */,
> -		0x5346414f /* OPENAFS_SUPER_MAGIC */,
> -		0x794C7630 /* OVERLAYFS_SUPER_MAGIC */,
> -		0xAAD7AAEA /* PANFS_SUPER_MAGIC */,
> -		0x52654973 /* REISERFS_SUPER_MAGIC */,
> -		0xFE534D42 /* SMB2_SUPER_MAGIC */,
> -		0x73717368 /* SQUASHFS_MAGIC */,
> -		0x01021994 /* TMPFS_MAGIC */,
> -		0x24051905 /* UBIFS_SUPER_MAGIC */,
> -		0x18031977 /* WEKAFS_SUPER_MAGIC */,
> -#if __SIZEOF_LONG__ > 4
> -		0x736675005346544e /* UFSD */,
> -#endif
> -		0x58465342 /* XFS_SB_MAGIC */,
> -		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
> -		0x858458f6 /* RAMFS_MAGIC */,
> -	};
> -	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
> -		if (f_type_whitelist[i] == fs_buf.f_type)
> -			return 0;
> -	}
> -
> -	fprintf(stderr, "%s: mounting over filesystem type %#010lx is forbidden\n",
> -		progname, (unsigned long)fs_buf.f_type);
> -	return -1;
> +	return check_nonroot_fstype(progname, &fs_buf);
>  }
>  
>  static int open_fuse_device(const char *dev)
> @@ -1273,15 +936,10 @@ static int mount_fuse(const char *mnt, const char *opts, const char **type)
>  		return -1;
>  
>  	drop_privs();
> -	read_conf();
> +	read_conf(progname);
>  
> -	if (getuid() != 0 && mount_max != -1) {
> -		int mount_count = count_fuse_fs();
> -		if (mount_count >= mount_max) {
> -			fprintf(stderr, "%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n", progname, FUSE_CONF);
> -			goto fail_close_fd;
> -		}
> -	}
> +	if (getuid() != 0 && check_nonroot_mount_count(progname) != 0)
> +		goto fail_close_fd;
>  
>  	// Extract any options starting with "x-"
>  	res= extract_x_options(opts, &do_mount_opts, &x_opts);
> diff --git a/util/meson.build b/util/meson.build
> index 04ea5ac201340d..aa646ef3c77d16 100644
> --- a/util/meson.build
> +++ b/util/meson.build
> @@ -1,18 +1,18 @@
>  fuseconf_path = join_paths(get_option('prefix'), get_option('sysconfdir'), 'fuse.conf')
>  
> -executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c'],
> +executable('fusermount3', ['fusermount.c', '../lib/mount_util.c', '../lib/util.c', 'fuser_conf.c'],
>             include_directories: include_dirs,
>             install: true,
>             install_dir: get_option('bindir'),
>             c_args: '-DFUSE_CONF="@0@"'.format(fuseconf_path))
>  
>  if private_cfg.get('HAVE_SERVICEMOUNT', false)
> -  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c'],
> +  executable('fuservicemount3', ['mount_service.c', 'fuservicemount.c', '../lib/mount_util.c', 'fuser_conf.c'],
>               include_directories: include_dirs,
>               link_with: [ libfuse ],
>               install: true,
>               install_dir: get_option('sbindir'),
> -             c_args: '-DFUSE_USE_VERSION=319')
> +             c_args: ['-DFUSE_USE_VERSION=319', '-DFUSE_CONF="@0@"'.format(fuseconf_path)])
>  endif
>  
>  executable('mount.fuse3', ['mount.fuse.c'],
> 

