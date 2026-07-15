Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095753C10A6;
	Wed, 15 Jul 2026 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148113; cv=none; b=RXjMiIVASJW00atXWGg0ErL3ZWXup5fhbHhStijD9jiihohi4UUQPJSzbGlYaSGVKkvVSFktWLHG/ET2TDHvcx92+b3erQNubgdKhRWxU1ycK3LTzvyFXFxIEV7R0l0NZYlVgu98G/5hD3YKbl5bFAQU8OMqYOMbZaJzNy9YZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148113; c=relaxed/simple;
	bh=iRGP+KhfOcXUDEFMpp6eaVlXR0TsSJ+qALKKpG2f7sE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/HSJLuXgIUfwcYNC62n45jCVb13ImQJbYMIDHQBlHbQnM4lGlOxPvl0wcYz6Lm5Hvf1bmplq/hA8XQR8vPn45xArzb2EI9KC0aG7fAzkeEF5Lyv55LsGMaSXrEDzjFBnvdF+ddFZN2Vv6DGvXgs5OKuwf1eEJzRPxc/53kISN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qxlmIKvA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qxlmIKvA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=j6dSVKU7uqJzcLld5sg3b01pYEuIwC9TQXYMwN8mPoY=; b=qxlmIKvAcyMw4rA/3JHv9XVu11
	WcZ1u0IBMCBlsPW3GIDEYbkTqWWNi1H4d0RHn4wK/8PCcmf5ey61uLZTuK4eo2D0Z35Ny57+/hzCT
	CW3eJ3XrosbPMdyrXI1ufkMmg5oZSAyWkmbjktGSpupMkZEB+cBl7BY5tRs41wKR2IwIQS6jegJja
	TFhSv/HRTP7/T4QN/lQynktvSWwHxh1h/7LXcIVUQYzyuwP3FTdViQAnMcx4h7gL9JSUmlYp4vxsJ
	fvvE3WNJ9PEZa3QWuv4k89OYnKQdHOVJrJwm4pl9JNQn5/SxhyZiqZehw/kVpnTXKpAZydQy5JHnQ
	iw9/zzEQ==;
Received: from bl15-239-28.dsl.telepac.pt ([188.80.239.28] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wk6QI-00FdH5-IS; Wed, 15 Jul 2026 22:41:42 +0200
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,  Miklos Szeredi
 <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  fuse-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] selftests/fuse: add ACL_DONT_CACHE regression test
In-Reply-To: <CAOQ4uxjzAXgBaggRNJxcEn39LY4+D6ZVHLqODJ3C6cHnDdkG_g@mail.gmail.com>
	(Amir Goldstein's message of "Wed, 15 Jul 2026 19:38:47 +0200")
References: <20260713220932.413004-1-amir73il@gmail.com>
	<20260713220932.413004-3-amir73il@gmail.com>
	<87wluw2qeh.fsf@wotan.olymp>
	<CAOQ4uxjzAXgBaggRNJxcEn39LY4+D6ZVHLqODJ3C6cHnDdkG_g@mail.gmail.com>
Date: Wed, 15 Jul 2026 21:42:03 +0100
Message-ID: <87se5k2des.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

On Wed, Jul 15 2026, Amir Goldstein wrote:

[...]
>> A question: in my own tests I have been following a different approach,
>> where the filesystem is mounted from a shell script that does the actual
>> testing.  I wonder if you think your approach (i.e. writing the actual
>> test in C, using the kselftest macros) is the preferred one.
>
> I always prefer a standalone C program for a selftest.
> For fstests naturally the tests are done by the shell scripts,
> so it really depends.

Cool, thanks.  I'll consider adapting my own tests to have a similar
format as this one.

>> Anyway, the test looks good to me, and I just have a few minor comments
>> below.
>>
>> > fuse_acl_cache_test is only built when libfuse3 is detected via
>> > pkg-config.
>>
>> Yeah, I've sent a patch recently converting the only existing test to al=
so
>> user fuse3 instead.  Not sure that's acceptable though, since there's a
>> chance of breaking some CI.
>
> I mean if the test is not built it wont run, so I don't know why CI would=
 fail.
> Obviously some systems do not have libfuse. That's fine by me
> not everyone needs to run all the tests.

Oh! as usual my comment wasn't clear :-)

In fact, my comment wasn't really very relevant in the context of this
patch as, in my opinion, I think it's OK for new tests to depend on fuse3.

I was talking about my own patch[1] which was converting the existing
test, which depends on fuse2, to use fuse3.  That's what I was referring
to when talking about breaking CI: we could have a scenario where a test
was being built and executed and, because it's now using fuse3, it can't
be built any more.

[1] https://lore.kernel.org/all/20260708131122.2917-3-luis@igalia.com/

>
> Thanks for the review!

I had two extra comments below, not sure you saw them ;-)

Cheers,
--=20
Lu=C3=ADs

> Amir.
>
>>
>> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>> > ---
>> >  .../selftests/filesystems/fuse/Makefile       |  10 +
>> >  .../filesystems/fuse/fuse_acl_cache_test.c    | 348 ++++++++++++++++++
>> >  2 files changed, 358 insertions(+)
>> >  create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_acl_=
cache_test.c
>> >
>> > diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools=
/testing/selftests/filesystems/fuse/Makefile
>> > index 612aad69a93aa..f471414842750 100644
>> > --- a/tools/testing/selftests/filesystems/fuse/Makefile
>> > +++ b/tools/testing/selftests/filesystems/fuse/Makefile
>> > @@ -5,6 +5,13 @@ CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES)
>> >  TEST_GEN_PROGS :=3D fusectl_test
>> >  TEST_GEN_FILES :=3D fuse_mnt
>> >
>> > +# fuse_acl_cache_test requires libfuse3; add it only when the library=
 is present.
>> > +ACL_CFLAGS :=3D $(shell pkg-config fuse3 --cflags 2>/dev/null)
>> > +ACL_LDLIBS :=3D $(shell pkg-config fuse3 --libs 2>/dev/null)
>> > +ifneq ($(ACL_CFLAGS),)
>> > +TEST_GEN_PROGS +=3D fuse_acl_cache_test
>> > +endif
>> > +
>> >  include ../../lib.mk
>> >
>> >  VAR_CFLAGS :=3D $(shell pkg-config fuse --cflags 2>/dev/null)
>> > @@ -19,3 +26,6 @@ endif
>> >
>> >  $(OUTPUT)/fuse_mnt: CFLAGS +=3D $(VAR_CFLAGS)
>> >  $(OUTPUT)/fuse_mnt: LDLIBS +=3D $(VAR_LDLIBS)
>> > +
>> > +$(OUTPUT)/fuse_acl_cache_test: CFLAGS +=3D $(ACL_CFLAGS)
>> > +$(OUTPUT)/fuse_acl_cache_test: LDLIBS +=3D $(ACL_LDLIBS)
>> > diff --git a/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_t=
est.c b/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c
>> > new file mode 100644
>> > index 0000000000000..b2e5db8555040
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c
>> > @@ -0,0 +1,348 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/*
>> > + * Test: FUSE ACL caching bug triggered by AT_STATX_FORCE_SYNC
>> > + *
>> > + * A FUSE mount that does not negotiate FUSE_POSIX_ACL initialises ev=
ery inode
>> > + * with i_acl =3D i_default_acl =3D ACL_DONT_CACHE.  When a fresh sta=
t is needed
>> > + * (e.g. AT_STATX_FORCE_SYNC), fuse_update_get_attr() calls
>> > + * forget_all_cached_acls() before issuing FUSE_GETATTR.  On an unfix=
ed kernel,
>> > + * __forget_cached_acl() replaces ACL_DONT_CACHE with ACL_NOT_CACHED,
>> > + * inadvertently enabling the kernel ACL cache for that inode.  The n=
ext
>> > + * getxattr populates the cache.  Because fuse_set_acl() skips
>> > + * forget_all_cached_acls() for !fc->posix_acl mounts, any subsequent=
 change to
>> > + * the ACL leaves the stale kernel entry in place, and the next getxa=
ttr returns
>> > + * wrong data without ever reaching the FUSE daemon.
>> > + *
>> > + * Fix (fs/posix_acl.c): __forget_cached_acl() returns early when *p =
is
>> > + * ACL_DONT_CACHE, preserving the "never cache" invariant for the ino=
de's
>> > + * lifetime.
>> > + *
>> > + * Test outline:
>> > + *  1. Mount a minimal FUSE fs (no FUSE_POSIX_ACL negotiated).
>> > + *  2. lgetxattr -> daemon called, ACL_A returned, NOT cached (ACL_DO=
NT_CACHE).
>> > + *  3. statx(AT_STATX_FORCE_SYNC) -> forget_all_cached_acls() called.
>> > + *     Buggy:  ACL_DONT_CACHE -> ACL_NOT_CACHED (cache enabled).
>> > + *     Fixed:  ACL_DONT_CACHE preserved.
>> > + *  4. lgetxattr -> daemon called, ACL_A returned.
>> > + *     Buggy:  result now cached (ACL_NOT_CACHED -> cached).
>> > + *     Fixed:  result still not cached.
>> > + *  5. Daemon switches to ACL_B internally (different size).
>> > + *  6. lgetxattr -> should return ACL_B (44 bytes).
>> > + *     Buggy:  cache hit, returns stale ACL_A (28 bytes). FAIL.
>> > + *     Fixed:  no cache, daemon called, returns ACL_B (44 bytes). PAS=
S.
>> > + */
>> > +
>> > +#define _GNU_SOURCE
>> > +#include <errno.h>
>> > +#include <fcntl.h>
>> > +#include <linux/limits.h>
>> > +#include <pthread.h>
>> > +#include <stdint.h>
>> > +#include <stdio.h>
>> > +#include <stdlib.h>
>> > +#include <string.h>
>> > +#include <sys/stat.h>
>> > +#include <sys/syscall.h>
>> > +#include <sys/xattr.h>
>> > +#include <unistd.h>
>> > +
>> > +#define FUSE_USE_VERSION 31
>> > +#include <fuse_lowlevel.h>
>> > +
>> > +#include "kselftest_harness.h"
>> > +
>> > +/* ---- ACL binary encoding -----------------------------------------=
------- */
>> > +/*
>> > + * POSIX ACL v2 xattr format (little-endian):
>> > + *   header: u32 version (=3D 0x00000002)
>> > + *   entry:  u16 tag | u16 perm | u32 id
>> > + *
>> > + * Entries must appear in tag-ascending order; named USER/GROUP entri=
es
>> > + * require a MASK entry.  Both ACLs pass posix_acl_from_xattr() valid=
ation.
>> > + */
>> > +
>> > +/* ACL_A: 3 entries (USER_OBJ:rwx, GROUP_OBJ:r-x, OTHER:r-x) =3D 28 b=
ytes */
>> > +static const uint8_t acl_a[] =3D {
>> > +     0x02, 0x00, 0x00, 0x00,                         /* v2 header    =
  */
>> > +     0x01, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* USER_OBJ  rwx=
  */
>> > +     0x04, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* GROUP_OBJ r-x=
  */
>> > +     0x20, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* OTHER     r-x=
  */
>> > +};
>>
>> Wouldn't it be OK to add a dependency on libacl to make this more
>> readable?
>>
>> >
>> > +
>> > +/*
>> > + * ACL_B: 5 entries =E2=80=94 adds USER uid=3D1 and MASK =3D 44 bytes.
>> > + * A named USER entry requires a MASK; all tags in ascending order.
>> > + */
>> > +static const uint8_t acl_b[] =3D {
>> > +     0x02, 0x00, 0x00, 0x00,                         /* v2 header    =
   */
>> > +     0x01, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* USER_OBJ   rw=
x  */
>> > +     0x02, 0x00, 0x07, 0x00, 0x01, 0x00, 0x00, 0x00, /* USER uid=3D1 =
rwx  */
>> > +     0x04, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* GROUP_OBJ  r-=
x  */
>> > +     0x10, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* MASK       rw=
x  */
>> > +     0x20, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* OTHER      r-=
x  */
>> > +};
>> > +
>> > +/* ---- Shared state (daemon thread <-> test thread) ----------------=
------- */
>> > +
>> > +#define FILE_INO  2
>> > +#define FILE_NAME "testfile"
>> > +
>> > +struct daemon_state {
>> > +     pthread_mutex_t lock;
>> > +     const uint8_t  *acl;
>> > +     size_t          acl_size;
>> > +     int             getxattr_count;
>> > +};
>> > +
>> > +/*
>> > + * Global: callbacks are stateless fns so we use a single global.
>> > + * Safe because only one test instance runs at a time.
>> > + */
>> > +static struct daemon_state g_ds =3D {
>> > +     .lock =3D PTHREAD_MUTEX_INITIALIZER,
>> > +};
>> > +
>> > +/* ---- FUSE lowlevel callbacks -------------------------------------=
------- */
>> > +
>> > +static void fs_lookup(fuse_req_t req, fuse_ino_t parent, const char *=
name)
>> > +{
>> > +     if (parent !=3D FUSE_ROOT_ID || strcmp(name, FILE_NAME)) {
>> > +             fuse_reply_err(req, ENOENT);
>> > +             return;
>> > +     }
>> > +     struct fuse_entry_param e =3D {};
>> > +
>> > +     /*
>> > +      * Long attr/entry timeouts so that normal stat() calls do not
>> > +      * expire and trigger forget_all_cached_acls() on their own;
>> > +      * only the explicit AT_STATX_FORCE_SYNC should trigger it.
>> > +      */
>> > +     e.ino             =3D FILE_INO;
>> > +     e.generation      =3D 1;
>> > +     e.attr_timeout    =3D 10.0;
>> > +     e.entry_timeout   =3D 10.0;
>> > +     e.attr.st_ino     =3D FILE_INO;
>> > +     e.attr.st_mode    =3D S_IFREG | 0644;
>> > +     e.attr.st_nlink   =3D 1;
>> > +     fuse_reply_entry(req, &e);
>> > +}
>> > +
>> > +static void fs_getattr(fuse_req_t req, fuse_ino_t ino,
>> > +                    struct fuse_file_info *fi)
>> > +{
>> > +     struct stat st =3D {};
>> > +
>> > +     (void)fi;
>> > +     if (ino =3D=3D FUSE_ROOT_ID) {
>> > +             st.st_ino   =3D FUSE_ROOT_ID;
>> > +             st.st_mode  =3D S_IFDIR | 0755;
>> > +             st.st_nlink =3D 2;
>> > +     } else if (ino =3D=3D FILE_INO) {
>> > +             st.st_ino   =3D FILE_INO;
>> > +             st.st_mode  =3D S_IFREG | 0644;
>> > +             st.st_nlink =3D 1;
>> > +     } else {
>> > +             fuse_reply_err(req, ENOENT);
>> > +             return;
>> > +     }
>> > +     fuse_reply_attr(req, &st, 10);
>> > +}
>> > +
>> > +static void fs_getxattr(fuse_req_t req, fuse_ino_t ino, const char *n=
ame,
>> > +                     size_t size)
>> > +{
>> > +     if (ino !=3D FILE_INO ||
>> > +         strcmp(name, "system.posix_acl_access") !=3D 0) {
>> > +             fuse_reply_err(req, ENODATA);
>> > +             return;
>> > +     }
>> > +
>> > +     pthread_mutex_lock(&g_ds.lock);
>> > +     const uint8_t *acl      =3D g_ds.acl;
>> > +     size_t         acl_size =3D g_ds.acl_size;
>> > +     g_ds.getxattr_count++;
>> > +     pthread_mutex_unlock(&g_ds.lock);
>> > +
>> > +     if (size =3D=3D 0)
>> > +             fuse_reply_xattr(req, acl_size);
>> > +     else if (size < acl_size)
>> > +             fuse_reply_err(req, ERANGE);
>> > +     else
>> > +             fuse_reply_buf(req, (const char *)acl, acl_size);
>> > +}
>> > +
>> > +static const struct fuse_lowlevel_ops fs_ops =3D {
>> > +     .lookup   =3D fs_lookup,
>> > +     .getattr  =3D fs_getattr,
>> > +     .getxattr =3D fs_getxattr,
>> > +};
>> > +
>> > +/* ---- Daemon thread -----------------------------------------------=
-------- */
>> > +
>> > +static void *run_daemon(void *arg)
>> > +{
>> > +     fuse_session_loop((struct fuse_session *)arg);
>> > +     return NULL;
>> > +}
>> > +
>> > +/* ---- kselftest harness -------------------------------------------=
-------- */
>> > +
>> > +FIXTURE(acl_cache) {
>> > +     struct fuse_session *se;
>> > +     char                 mountpoint[PATH_MAX];
>> > +     char                 file_path[PATH_MAX];
>> > +     pthread_t            thread;
>> > +};
>> > +
>> > +FIXTURE_SETUP(acl_cache)
>> > +{
>> > +     char *fuse_argv[] =3D { "fuse_acl_cache_test", NULL };
>> > +     struct fuse_args args =3D FUSE_ARGS_INIT(1, fuse_argv);
>> > +
>> > +     g_ds.acl            =3D acl_a;
>> > +     g_ds.acl_size       =3D sizeof(acl_a);
>> > +     g_ds.getxattr_count =3D 0;
>> > +
>> > +     strcpy(self->mountpoint, "/tmp/acl_cache_test_XXXXXX");
>> > +     if (!mkdtemp(self->mountpoint))
>> > +             SKIP(return, "mkdtemp: %s", strerror(errno));
>> > +
>> > +     snprintf(self->file_path, sizeof(self->file_path),
>> > +              "%s/" FILE_NAME, self->mountpoint);
>> > +
>> > +     self->se =3D fuse_session_new(&args, &fs_ops, sizeof(fs_ops), NU=
LL);
>> > +     if (!self->se) {
>> > +             rmdir(self->mountpoint);
>> > +             SKIP(return, "fuse_session_new failed");
>> > +     }
>> > +
>> > +     if (fuse_session_mount(self->se, self->mountpoint)) {
>> > +             fuse_session_destroy(self->se);
>> > +             rmdir(self->mountpoint);
>> > +             SKIP(return, "fuse_session_mount failed "
>> > +                          "(missing fusermount3 or insufficient privi=
leges)");
>> > +     }
>> > +
>> > +     if (pthread_create(&self->thread, NULL, run_daemon, self->se)) {
>> > +             fuse_session_unmount(self->se);
>> > +             fuse_session_destroy(self->se);
>> > +             rmdir(self->mountpoint);
>> > +             SKIP(return, "pthread_create: %s", strerror(errno));
>> > +     }
>> > +
>> > +     fuse_opt_free_args(&args);
>> > +}
>> > +
>> > +FIXTURE_TEARDOWN(acl_cache)
>> > +{
>> > +     fuse_session_exit(self->se);
>> > +     fuse_session_unmount(self->se);
>> > +     pthread_join(self->thread, NULL);
>> > +     fuse_session_destroy(self->se);
>> > +     rmdir(self->mountpoint);
>> > +}
>> > +
>> > +static int do_force_statx(const char *path)
>> > +{
>> > +     struct statx stx;
>> > +
>> > +     return syscall(SYS_statx, AT_FDCWD, path,
>> > +                    AT_STATX_FORCE_SYNC, STATX_BASIC_STATS, &stx);
>> > +}
>> > +
>> > +TEST_F(acl_cache, stale_after_force_sync)
>> > +{
>> > +     char    buf[512];
>> > +     ssize_t sz;
>> > +     int     count;
>> > +
>> > +     /*
>> > +      * Step 1: two getxattr calls before any statx(FORCE_SYNC).
>> > +      * i_acl =3D=3D ACL_DONT_CACHE.  __get_acl's cmpxchg(p, ACL_NOT_=
CACHED,
>> > +      * sentinel) finds *p !=3D ACL_NOT_CACHED on every call, so the =
sentinel
>> > +      * is never placed and the result is never cached.  Both calls m=
ust
>> > +      * reach the daemon, proving ACL_DONT_CACHE suppresses caching.
>> > +      */
>> > +     sz =3D lgetxattr(self->file_path, "system.posix_acl_access",
>> > +                    buf, sizeof(buf));
>> > +     ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
>> > +
>> > +     sz =3D lgetxattr(self->file_path, "system.posix_acl_access",
>> > +                    buf, sizeof(buf));
>> > +     ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
>> > +
>> > +     pthread_mutex_lock(&g_ds.lock);
>> > +     count =3D g_ds.getxattr_count;
>> > +     pthread_mutex_unlock(&g_ds.lock);
>> > +
>> > +     ASSERT_EQ(count, 2);
>> > +     TH_LOG("step 1 OK: both pre-trigger getxattrs reached daemon (co=
unt=3D%d), "
>> > +            "ACL_DONT_CACHE is working", count);
>> > +
>> > +     /*
>> > +      * Step 2: statx(AT_STATX_FORCE_SYNC).
>> > +      * fuse_update_get_attr() calls forget_all_cached_acls() before =
sending
>> > +      * FUSE_GETATTR.
>> > +      *   Buggy kernel:  ACL_DONT_CACHE -> ACL_NOT_CACHED  (cache ena=
bled)
>> > +      *   Fixed kernel:  ACL_DONT_CACHE preserved           (no effec=
t)
>> > +      */
>> > +     ASSERT_EQ(do_force_statx(self->file_path), 0);
>>
>> Why not calling statx(2) instead?  Are you using a libc that doesn't
>> include a wrapper?
>>
>> (Also, I wonder if having the global state protected with a mutex is
>> really needed in the scope of this test... but yeah, that's the correct
>> thing to do, of course.)
>>
>> Cheers,
>> --
>> Lu=C3=ADs
>>
>> >
>> > +     TH_LOG("step 2 OK: statx(AT_STATX_FORCE_SYNC) succeeded");
>> > +
>> > +     /*
>> > +      * Step 3: getxattr =E2=80=94 cache population attempt after the=
 trigger.
>> > +      *   Buggy:  *p =3D=3D ACL_NOT_CACHED -> sentinel placed -> fuse=
_get_inode_acl
>> > +      *           called -> ACL_A parsed and stored in the kernel cac=
he.
>> > +      *   Fixed:  *p =3D=3D ACL_DONT_CACHE -> sentinel placement skip=
ped ->
>> > +      *           fuse_get_inode_acl called but result not cached.
>> > +      * Either way the correct ACL_A is returned here.
>> > +      */
>> > +     sz =3D lgetxattr(self->file_path, "system.posix_acl_access",
>> > +                    buf, sizeof(buf));
>> > +     ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
>> > +
>> > +     pthread_mutex_lock(&g_ds.lock);
>> > +     count =3D g_ds.getxattr_count;
>> > +     pthread_mutex_unlock(&g_ds.lock);
>> > +
>> > +     ASSERT_EQ(count, 3);
>> > +     TH_LOG("step 3 OK: post-trigger getxattr reached daemon (count=
=3D%d), "
>> > +            "returned correct ACL_A (%zd bytes)", count, sz);
>> > +
>> > +     /*
>> > +      * Step 4: switch daemon to ACL_B (different size: 44 vs 28 byte=
s).
>> > +      * Simulates an ACL change that fuse_set_acl() would NOT invalid=
ate for
>> > +      * !fc->posix_acl mounts (it skips forget_all_cached_acls in tha=
t case).
>> > +      * On a fixed kernel the ACL was never cached, so this is moot.
>> > +      */
>> > +     pthread_mutex_lock(&g_ds.lock);
>> > +     g_ds.acl      =3D acl_b;
>> > +     g_ds.acl_size =3D sizeof(acl_b);
>> > +     pthread_mutex_unlock(&g_ds.lock);
>> > +     TH_LOG("step 4: daemon switched to ACL_B (%zu bytes)", sizeof(ac=
l_b));
>> > +
>> > +     /*
>> > +      * Step 5: getxattr =E2=80=94 the decisive check.
>> > +      *   Buggy kernel:  cache hit -> stale ACL_A (28 bytes), count s=
tays 3.
>> > +      *   Fixed kernel:  no cache -> daemon called -> ACL_B (44 bytes=
), count 4.
>> > +      */
>> > +     sz =3D lgetxattr(self->file_path, "system.posix_acl_access",
>> > +                    buf, sizeof(buf));
>> > +
>> > +     pthread_mutex_lock(&g_ds.lock);
>> > +     count =3D g_ds.getxattr_count;
>> > +     pthread_mutex_unlock(&g_ds.lock);
>> > +
>> > +     if (sz =3D=3D (ssize_t)sizeof(acl_a))
>> > +             TH_LOG("step 5 BUG: stale ACL_A (%zd bytes) from kernel =
cache "
>> > +                    "(count=3D%d); ACL_DONT_CACHE corrupted by "
>> > +                    "forget_all_cached_acls()", sz, count);
>> > +     else
>> > +             TH_LOG("step 5 OK: daemon reached (count=3D%d), "
>> > +                    "fresh ACL_B (%zd bytes)", count, sz);
>> > +
>> > +     EXPECT_EQ(sz, (ssize_t)sizeof(acl_b));
>> > +     EXPECT_EQ(count, 4);
>> > +}
>> > +
>> > +TEST_HARNESS_MAIN
>> > --
>> > 2.54.0
>> >
>>

