Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC446AF35
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137144; cv=pass; b=jbXi6elBwcJ37FAJbvrVhkn6sz7D8ONjBnJUzbxCYB3IehuBajbc5TRWOvJf28oxs392PGPKFwA6D8R1uSN+/HRLe2533Js+fWxLUbQ3UVSYr/MTiKipto7eH/VHj9WHr06hPYPkqi32EKfCbRdnjON8VlUkL3+J74m31Ta6l4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137144; c=relaxed/simple;
	bh=l98eAIZJajIyavehqUU8rIoR8bS/bPWYA7lUvllH3oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lH26Tzqt9txSWLATl+t9T50XXmmzqiRlr46xu8IMDNJWkO5wVHEchD9MXKMo8aYWL+sZXi3GYsBKv38ps35UX5uUoeczEkFaOGwmMiqrPsnYgHkcelhisL665fURpezzCrnPZPkE3jDsOsL18cEjbjcL2zIBc8QXkEG/hcvFFM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUvFifsO; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUvFifsO"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so8985294a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 10:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784137140; cv=none;
        d=google.com; s=arc-20260327;
        b=R1ZjYURDPvZoI/smoy1/1PKyYicHer5QniyJo6Z4e9Vt4RiAP3tfvjFD0jtQyLEwvP
         RQiOehb+nBaNfd2YLfF4q4nurPsihpDcjNUEhVndCzi4o91EwtyvnsHZsM+W8dAP5j3C
         bY3h7p55XqCsYosDyymOVndpNidmDqimnDQjtJz+FOj61w9FCHJ6R0iOSW5iaSH5QCGG
         MCwrJiCK3emyDonJig54eogWiJTxj7lTxxLCRRDCSX1ddZaUKQCOPtX5R7WwVh6FVAR9
         JgpTeK8GAtjUEgXrMDYqkzVPeVQg9f9n8xWxQa4ZcxlJhAwAe5E0/8rZIkOaYkIDXU7L
         /Kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/syWsMeCRmCuls9K/HKnqZbwk5R1VA6vkTtLV9LLnMo=;
        fh=FatBp0isUHxkRwJCZjbEmg/gg6KuZX4gvdpRpsD1j9I=;
        b=LJC3BioEFfVgy5Bp3lfFJJVscioTh4jUXW64Tbp6fiC3l9IlMcB23/2nSinYlk/x4q
         qWggWUHykIeoT9R9EdSYhU4wjqmDGQkF4sIVdAEV5Om31xBlOKWo0Mrx8ljfO++XGt8x
         3xSI70o0GUIDse5bK/QmWhdjBKG7Gssej6Wv4sazI4FAqG2Bwq7i0Mo0OlrSA8uKiTxZ
         9kM+XpOFKaG9Qk7SCgCwh5y6WhySMTIBmLtGf6mikK9NGIlB1ekh8tBr58R778hRTyCA
         SgGRAtpHNkBe9u4AQoeA3RevBEW+JoeodGLYS4CwbZZyTIeSD5PL0zRzA18pPmosB7Jl
         SxCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784137140; x=1784741940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/syWsMeCRmCuls9K/HKnqZbwk5R1VA6vkTtLV9LLnMo=;
        b=SUvFifsOGzmjzhSANQJVhcag6NPUVLggk0EBYkKm6yJUYfg2ZO+zP+ToKkwOEpI/2u
         rVAxGoVxa8oMheq2Q6AmqjLHOedgrkpknsAsTKJGj89TeUPWNFHgiNArZDjMXyXaT51U
         xluJbpr85uQnKY8+ouigEmgoW5pTbPbqgnWgnwRjFi8jPNoiwGzcsnnadokQf5ybpm+T
         0IO+zV5QMzZRm5b9EGD25ADuVqM/uuZW6jz+ZraUR9XTikDOlv9bRL8JSkAMkoii0jpF
         EZ0pu2kp1/Ut6g8CvvHvakkB3ksNB6dyeUj8My9Dol+9jSQzYIlN+MxbxxVj+MIAWjGT
         lysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137140; x=1784741940;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/syWsMeCRmCuls9K/HKnqZbwk5R1VA6vkTtLV9LLnMo=;
        b=kJfD5Eh4M4NZ8IW7lf6e5GfZTVkRmcGwnhy4lfncFoZo4K481UmgYJwHdK3Tpv4e5p
         642HLXCbpCi+aKrlvYs6vCbkcDNZOw+fq1yE0Wp86pZbep2XUEzi7oZvVcrTk1jkeKJ7
         iby215B6C7HinhluDAyoj1VkyPmibCEp7i2IS+guOs47Unxk+SkPAwZgPmTj6JMSXmn8
         eTpHWoJHRUJ7+vBWykEakld5zyh7H9fN4CMkoe72g/+4O+qGacT+nW+WxvRfe63Nr5ro
         WDTDw3IyWHiAOza1dH6LZT6s44L10fLZNXX5Z9pxGE4JH/cvZmd3V2ielwPctNK5r70p
         BeJg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4CWXs2tlfZmNYTnZMexZP+x/ZWZ2PTHodswoWRD6SX7zMlSXjgLJjOkEBQ9cdh2ZhfxienuKNfwSMGUZn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu239xay7mSHf/e5/z+shS6ifRG1RsuDkmNw710QqtJw1Z5E8s
	voH3exto5gR5JltV7wpPeVVSKCLYxJ3eHQCHTB6MBzyRR3ykTgOB5F45P7n9jwr47aK1mcDPwvB
	i6A1v7MgORNlj4e7reDEnOxjZvVFZifg=
X-Gm-Gg: AfdE7ckTGO82T0zv48FuutQMopdee7yrvG6QAzIP3RDhk/iPtp96oXT/qQAgVa3hrVD
	qwPsxP3004ndqq1uOIzUPlIKWJhADIHh3q8CZPg9gJhqKYG7HfEAEHvWGknWfUIX10RtNy3ncWs
	I7viQ+zoOymmqrGYGRQK6yWL4ooBJp9pqzFolv6yutKqcMXJoihlOyeYRLrbue/39GhIqCMVjOx
	xoN/KoT/hPwHdNzdZIMRMVen/OqwO7ZaASobLO90jWKauOtagHgviIGFRYJO7JcwHSCJOid8F7+
	0SE5JU/N
X-Received: by 2002:a05:6402:a515:10b0:69e:2585:7e6 with SMTP id
 4fb4d7f45d1cf-69e258509c3mr1081427a12.30.1784137139761; Wed, 15 Jul 2026
 10:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713220932.413004-1-amir73il@gmail.com> <20260713220932.413004-3-amir73il@gmail.com>
 <87wluw2qeh.fsf@wotan.olymp>
In-Reply-To: <87wluw2qeh.fsf@wotan.olymp>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Jul 2026 19:38:47 +0200
X-Gm-Features: AUfX_mwT5l6TgDp1jG6EPPCXg1XNmSFu-XYbyBVG_YWIduC-MldJ6mRLfVzhDAQ
Message-ID: <CAOQ4uxjzAXgBaggRNJxcEn39LY4+D6ZVHLqODJ3C6cHnDdkG_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/fuse: add ACL_DONT_CACHE regression test
To: Luis Henriques <luis@igalia.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 6:01=E2=80=AFPM Luis Henriques <luis@igalia.com> wr=
ote:
>
> Hi Amir,
>
> On Tue, Jul 14 2026, Amir Goldstein wrote:
>
> > Add a test that reproduces the stale ACL bug fixed by:
> >   "fs: preserve ACL_DONT_CACHE state in forget_cached_acl()"
> >
> > A FUSE mount that does not negotiate FUSE_POSIX_ACL initialises inodes
> > with i_acl =3D ACL_DONT_CACHE.  Before the fix, calling
> > forget_all_cached_acls() (e.g. from fuse_update_get_attr() on a
> > statx(AT_STATX_FORCE_SYNC)) would silently replace ACL_DONT_CACHE with
> > ACL_NOT_CACHED, enabling the kernel ACL cache.  A subsequent getxattr
> > would populate the cache, and because fuse_set_acl() skips
> > forget_all_cached_acls() for !fc->posix_acl, later ACL changes were
> > not visible to callers =E2=80=94 getxattr returned stale data.
> >
> > The test mounts a minimal libfuse3 lowlevel filesystem (no
> > FUSE_POSIX_ACL negotiated) and:
> >   1. Issues two getxattrs =E2=80=94 both must reach the daemon, proving
> >      ACL_DONT_CACHE suppresses caching before any trigger.
> >   2. Calls statx(AT_STATX_FORCE_SYNC) to trigger forget_all_cached_acls=
().
> >   3. Issues another getxattr (populates the cache on a buggy kernel).
> >   4. Switches the daemon to a different-sized ACL (ACL_B).
> >   5. Issues a final getxattr =E2=80=94 expects ACL_B (44 bytes) and dae=
mon
> >      call count 4; a buggy kernel returns stale ACL_A (28 bytes).
>
> A question: in my own tests I have been following a different approach,
> where the filesystem is mounted from a shell script that does the actual
> testing.  I wonder if you think your approach (i.e. writing the actual
> test in C, using the kselftest macros) is the preferred one.

I always prefer a standalone C program for a selftest.
For fstests naturally the tests are done by the shell scripts,
so it really depends.

>
> Anyway, the test looks good to me, and I just have a few minor comments
> below.
>
> > fuse_acl_cache_test is only built when libfuse3 is detected via
> > pkg-config.
>
> Yeah, I've sent a patch recently converting the only existing test to als=
o
> user fuse3 instead.  Not sure that's acceptable though, since there's a
> chance of breaking some CI.

I mean if the test is not built it wont run, so I don't know why CI would f=
ail.
Obviously some systems do not have libfuse. That's fine by me
not everyone needs to run all the tests.

Thanks for the review!
Amir.

>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  .../selftests/filesystems/fuse/Makefile       |  10 +
> >  .../filesystems/fuse/fuse_acl_cache_test.c    | 348 ++++++++++++++++++
> >  2 files changed, 358 insertions(+)
> >  create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_acl_c=
ache_test.c
> >
> > diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/=
testing/selftests/filesystems/fuse/Makefile
> > index 612aad69a93aa..f471414842750 100644
> > --- a/tools/testing/selftests/filesystems/fuse/Makefile
> > +++ b/tools/testing/selftests/filesystems/fuse/Makefile
> > @@ -5,6 +5,13 @@ CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES)
> >  TEST_GEN_PROGS :=3D fusectl_test
> >  TEST_GEN_FILES :=3D fuse_mnt
> >
> > +# fuse_acl_cache_test requires libfuse3; add it only when the library =
is present.
> > +ACL_CFLAGS :=3D $(shell pkg-config fuse3 --cflags 2>/dev/null)
> > +ACL_LDLIBS :=3D $(shell pkg-config fuse3 --libs 2>/dev/null)
> > +ifneq ($(ACL_CFLAGS),)
> > +TEST_GEN_PROGS +=3D fuse_acl_cache_test
> > +endif
> > +
> >  include ../../lib.mk
> >
> >  VAR_CFLAGS :=3D $(shell pkg-config fuse --cflags 2>/dev/null)
> > @@ -19,3 +26,6 @@ endif
> >
> >  $(OUTPUT)/fuse_mnt: CFLAGS +=3D $(VAR_CFLAGS)
> >  $(OUTPUT)/fuse_mnt: LDLIBS +=3D $(VAR_LDLIBS)
> > +
> > +$(OUTPUT)/fuse_acl_cache_test: CFLAGS +=3D $(ACL_CFLAGS)
> > +$(OUTPUT)/fuse_acl_cache_test: LDLIBS +=3D $(ACL_LDLIBS)
> > diff --git a/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_te=
st.c b/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c
> > new file mode 100644
> > index 0000000000000..b2e5db8555040
> > --- /dev/null
> > +++ b/tools/testing/selftests/filesystems/fuse/fuse_acl_cache_test.c
> > @@ -0,0 +1,348 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Test: FUSE ACL caching bug triggered by AT_STATX_FORCE_SYNC
> > + *
> > + * A FUSE mount that does not negotiate FUSE_POSIX_ACL initialises eve=
ry inode
> > + * with i_acl =3D i_default_acl =3D ACL_DONT_CACHE.  When a fresh stat=
 is needed
> > + * (e.g. AT_STATX_FORCE_SYNC), fuse_update_get_attr() calls
> > + * forget_all_cached_acls() before issuing FUSE_GETATTR.  On an unfixe=
d kernel,
> > + * __forget_cached_acl() replaces ACL_DONT_CACHE with ACL_NOT_CACHED,
> > + * inadvertently enabling the kernel ACL cache for that inode.  The ne=
xt
> > + * getxattr populates the cache.  Because fuse_set_acl() skips
> > + * forget_all_cached_acls() for !fc->posix_acl mounts, any subsequent =
change to
> > + * the ACL leaves the stale kernel entry in place, and the next getxat=
tr returns
> > + * wrong data without ever reaching the FUSE daemon.
> > + *
> > + * Fix (fs/posix_acl.c): __forget_cached_acl() returns early when *p i=
s
> > + * ACL_DONT_CACHE, preserving the "never cache" invariant for the inod=
e's
> > + * lifetime.
> > + *
> > + * Test outline:
> > + *  1. Mount a minimal FUSE fs (no FUSE_POSIX_ACL negotiated).
> > + *  2. lgetxattr -> daemon called, ACL_A returned, NOT cached (ACL_DON=
T_CACHE).
> > + *  3. statx(AT_STATX_FORCE_SYNC) -> forget_all_cached_acls() called.
> > + *     Buggy:  ACL_DONT_CACHE -> ACL_NOT_CACHED (cache enabled).
> > + *     Fixed:  ACL_DONT_CACHE preserved.
> > + *  4. lgetxattr -> daemon called, ACL_A returned.
> > + *     Buggy:  result now cached (ACL_NOT_CACHED -> cached).
> > + *     Fixed:  result still not cached.
> > + *  5. Daemon switches to ACL_B internally (different size).
> > + *  6. lgetxattr -> should return ACL_B (44 bytes).
> > + *     Buggy:  cache hit, returns stale ACL_A (28 bytes). FAIL.
> > + *     Fixed:  no cache, daemon called, returns ACL_B (44 bytes). PASS=
.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <linux/limits.h>
> > +#include <pthread.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/stat.h>
> > +#include <sys/syscall.h>
> > +#include <sys/xattr.h>
> > +#include <unistd.h>
> > +
> > +#define FUSE_USE_VERSION 31
> > +#include <fuse_lowlevel.h>
> > +
> > +#include "kselftest_harness.h"
> > +
> > +/* ---- ACL binary encoding ------------------------------------------=
------ */
> > +/*
> > + * POSIX ACL v2 xattr format (little-endian):
> > + *   header: u32 version (=3D 0x00000002)
> > + *   entry:  u16 tag | u16 perm | u32 id
> > + *
> > + * Entries must appear in tag-ascending order; named USER/GROUP entrie=
s
> > + * require a MASK entry.  Both ACLs pass posix_acl_from_xattr() valida=
tion.
> > + */
> > +
> > +/* ACL_A: 3 entries (USER_OBJ:rwx, GROUP_OBJ:r-x, OTHER:r-x) =3D 28 by=
tes */
> > +static const uint8_t acl_a[] =3D {
> > +     0x02, 0x00, 0x00, 0x00,                         /* v2 header     =
 */
> > +     0x01, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* USER_OBJ  rwx =
 */
> > +     0x04, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* GROUP_OBJ r-x =
 */
> > +     0x20, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* OTHER     r-x =
 */
> > +};
>
> Wouldn't it be OK to add a dependency on libacl to make this more
> readable?
>
> >
> > +
> > +/*
> > + * ACL_B: 5 entries =E2=80=94 adds USER uid=3D1 and MASK =3D 44 bytes.
> > + * A named USER entry requires a MASK; all tags in ascending order.
> > + */
> > +static const uint8_t acl_b[] =3D {
> > +     0x02, 0x00, 0x00, 0x00,                         /* v2 header     =
  */
> > +     0x01, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* USER_OBJ   rwx=
  */
> > +     0x02, 0x00, 0x07, 0x00, 0x01, 0x00, 0x00, 0x00, /* USER uid=3D1 r=
wx  */
> > +     0x04, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* GROUP_OBJ  r-x=
  */
> > +     0x10, 0x00, 0x07, 0x00, 0xff, 0xff, 0xff, 0xff, /* MASK       rwx=
  */
> > +     0x20, 0x00, 0x05, 0x00, 0xff, 0xff, 0xff, 0xff, /* OTHER      r-x=
  */
> > +};
> > +
> > +/* ---- Shared state (daemon thread <-> test thread) -----------------=
------ */
> > +
> > +#define FILE_INO  2
> > +#define FILE_NAME "testfile"
> > +
> > +struct daemon_state {
> > +     pthread_mutex_t lock;
> > +     const uint8_t  *acl;
> > +     size_t          acl_size;
> > +     int             getxattr_count;
> > +};
> > +
> > +/*
> > + * Global: callbacks are stateless fns so we use a single global.
> > + * Safe because only one test instance runs at a time.
> > + */
> > +static struct daemon_state g_ds =3D {
> > +     .lock =3D PTHREAD_MUTEX_INITIALIZER,
> > +};
> > +
> > +/* ---- FUSE lowlevel callbacks --------------------------------------=
------ */
> > +
> > +static void fs_lookup(fuse_req_t req, fuse_ino_t parent, const char *n=
ame)
> > +{
> > +     if (parent !=3D FUSE_ROOT_ID || strcmp(name, FILE_NAME)) {
> > +             fuse_reply_err(req, ENOENT);
> > +             return;
> > +     }
> > +     struct fuse_entry_param e =3D {};
> > +
> > +     /*
> > +      * Long attr/entry timeouts so that normal stat() calls do not
> > +      * expire and trigger forget_all_cached_acls() on their own;
> > +      * only the explicit AT_STATX_FORCE_SYNC should trigger it.
> > +      */
> > +     e.ino             =3D FILE_INO;
> > +     e.generation      =3D 1;
> > +     e.attr_timeout    =3D 10.0;
> > +     e.entry_timeout   =3D 10.0;
> > +     e.attr.st_ino     =3D FILE_INO;
> > +     e.attr.st_mode    =3D S_IFREG | 0644;
> > +     e.attr.st_nlink   =3D 1;
> > +     fuse_reply_entry(req, &e);
> > +}
> > +
> > +static void fs_getattr(fuse_req_t req, fuse_ino_t ino,
> > +                    struct fuse_file_info *fi)
> > +{
> > +     struct stat st =3D {};
> > +
> > +     (void)fi;
> > +     if (ino =3D=3D FUSE_ROOT_ID) {
> > +             st.st_ino   =3D FUSE_ROOT_ID;
> > +             st.st_mode  =3D S_IFDIR | 0755;
> > +             st.st_nlink =3D 2;
> > +     } else if (ino =3D=3D FILE_INO) {
> > +             st.st_ino   =3D FILE_INO;
> > +             st.st_mode  =3D S_IFREG | 0644;
> > +             st.st_nlink =3D 1;
> > +     } else {
> > +             fuse_reply_err(req, ENOENT);
> > +             return;
> > +     }
> > +     fuse_reply_attr(req, &st, 10);
> > +}
> > +
> > +static void fs_getxattr(fuse_req_t req, fuse_ino_t ino, const char *na=
me,
> > +                     size_t size)
> > +{
> > +     if (ino !=3D FILE_INO ||
> > +         strcmp(name, "system.posix_acl_access") !=3D 0) {
> > +             fuse_reply_err(req, ENODATA);
> > +             return;
> > +     }
> > +
> > +     pthread_mutex_lock(&g_ds.lock);
> > +     const uint8_t *acl      =3D g_ds.acl;
> > +     size_t         acl_size =3D g_ds.acl_size;
> > +     g_ds.getxattr_count++;
> > +     pthread_mutex_unlock(&g_ds.lock);
> > +
> > +     if (size =3D=3D 0)
> > +             fuse_reply_xattr(req, acl_size);
> > +     else if (size < acl_size)
> > +             fuse_reply_err(req, ERANGE);
> > +     else
> > +             fuse_reply_buf(req, (const char *)acl, acl_size);
> > +}
> > +
> > +static const struct fuse_lowlevel_ops fs_ops =3D {
> > +     .lookup   =3D fs_lookup,
> > +     .getattr  =3D fs_getattr,
> > +     .getxattr =3D fs_getxattr,
> > +};
> > +
> > +/* ---- Daemon thread ------------------------------------------------=
------- */
> > +
> > +static void *run_daemon(void *arg)
> > +{
> > +     fuse_session_loop((struct fuse_session *)arg);
> > +     return NULL;
> > +}
> > +
> > +/* ---- kselftest harness --------------------------------------------=
------- */
> > +
> > +FIXTURE(acl_cache) {
> > +     struct fuse_session *se;
> > +     char                 mountpoint[PATH_MAX];
> > +     char                 file_path[PATH_MAX];
> > +     pthread_t            thread;
> > +};
> > +
> > +FIXTURE_SETUP(acl_cache)
> > +{
> > +     char *fuse_argv[] =3D { "fuse_acl_cache_test", NULL };
> > +     struct fuse_args args =3D FUSE_ARGS_INIT(1, fuse_argv);
> > +
> > +     g_ds.acl            =3D acl_a;
> > +     g_ds.acl_size       =3D sizeof(acl_a);
> > +     g_ds.getxattr_count =3D 0;
> > +
> > +     strcpy(self->mountpoint, "/tmp/acl_cache_test_XXXXXX");
> > +     if (!mkdtemp(self->mountpoint))
> > +             SKIP(return, "mkdtemp: %s", strerror(errno));
> > +
> > +     snprintf(self->file_path, sizeof(self->file_path),
> > +              "%s/" FILE_NAME, self->mountpoint);
> > +
> > +     self->se =3D fuse_session_new(&args, &fs_ops, sizeof(fs_ops), NUL=
L);
> > +     if (!self->se) {
> > +             rmdir(self->mountpoint);
> > +             SKIP(return, "fuse_session_new failed");
> > +     }
> > +
> > +     if (fuse_session_mount(self->se, self->mountpoint)) {
> > +             fuse_session_destroy(self->se);
> > +             rmdir(self->mountpoint);
> > +             SKIP(return, "fuse_session_mount failed "
> > +                          "(missing fusermount3 or insufficient privil=
eges)");
> > +     }
> > +
> > +     if (pthread_create(&self->thread, NULL, run_daemon, self->se)) {
> > +             fuse_session_unmount(self->se);
> > +             fuse_session_destroy(self->se);
> > +             rmdir(self->mountpoint);
> > +             SKIP(return, "pthread_create: %s", strerror(errno));
> > +     }
> > +
> > +     fuse_opt_free_args(&args);
> > +}
> > +
> > +FIXTURE_TEARDOWN(acl_cache)
> > +{
> > +     fuse_session_exit(self->se);
> > +     fuse_session_unmount(self->se);
> > +     pthread_join(self->thread, NULL);
> > +     fuse_session_destroy(self->se);
> > +     rmdir(self->mountpoint);
> > +}
> > +
> > +static int do_force_statx(const char *path)
> > +{
> > +     struct statx stx;
> > +
> > +     return syscall(SYS_statx, AT_FDCWD, path,
> > +                    AT_STATX_FORCE_SYNC, STATX_BASIC_STATS, &stx);
> > +}
> > +
> > +TEST_F(acl_cache, stale_after_force_sync)
> > +{
> > +     char    buf[512];
> > +     ssize_t sz;
> > +     int     count;
> > +
> > +     /*
> > +      * Step 1: two getxattr calls before any statx(FORCE_SYNC).
> > +      * i_acl =3D=3D ACL_DONT_CACHE.  __get_acl's cmpxchg(p, ACL_NOT_C=
ACHED,
> > +      * sentinel) finds *p !=3D ACL_NOT_CACHED on every call, so the s=
entinel
> > +      * is never placed and the result is never cached.  Both calls mu=
st
> > +      * reach the daemon, proving ACL_DONT_CACHE suppresses caching.
> > +      */
> > +     sz =3D lgetxattr(self->file_path, "system.posix_acl_access",
> > +                    buf, sizeof(buf));
> > +     ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
> > +
> > +     sz =3D lgetxattr(self->file_path, "system.posix_acl_access",
> > +                    buf, sizeof(buf));
> > +     ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
> > +
> > +     pthread_mutex_lock(&g_ds.lock);
> > +     count =3D g_ds.getxattr_count;
> > +     pthread_mutex_unlock(&g_ds.lock);
> > +
> > +     ASSERT_EQ(count, 2);
> > +     TH_LOG("step 1 OK: both pre-trigger getxattrs reached daemon (cou=
nt=3D%d), "
> > +            "ACL_DONT_CACHE is working", count);
> > +
> > +     /*
> > +      * Step 2: statx(AT_STATX_FORCE_SYNC).
> > +      * fuse_update_get_attr() calls forget_all_cached_acls() before s=
ending
> > +      * FUSE_GETATTR.
> > +      *   Buggy kernel:  ACL_DONT_CACHE -> ACL_NOT_CACHED  (cache enab=
led)
> > +      *   Fixed kernel:  ACL_DONT_CACHE preserved           (no effect=
)
> > +      */
> > +     ASSERT_EQ(do_force_statx(self->file_path), 0);
>
> Why not calling statx(2) instead?  Are you using a libc that doesn't
> include a wrapper?
>
> (Also, I wonder if having the global state protected with a mutex is
> really needed in the scope of this test... but yeah, that's the correct
> thing to do, of course.)
>
> Cheers,
> --
> Lu=C3=ADs
>
> >
> > +     TH_LOG("step 2 OK: statx(AT_STATX_FORCE_SYNC) succeeded");
> > +
> > +     /*
> > +      * Step 3: getxattr =E2=80=94 cache population attempt after the =
trigger.
> > +      *   Buggy:  *p =3D=3D ACL_NOT_CACHED -> sentinel placed -> fuse_=
get_inode_acl
> > +      *           called -> ACL_A parsed and stored in the kernel cach=
e.
> > +      *   Fixed:  *p =3D=3D ACL_DONT_CACHE -> sentinel placement skipp=
ed ->
> > +      *           fuse_get_inode_acl called but result not cached.
> > +      * Either way the correct ACL_A is returned here.
> > +      */
> > +     sz =3D lgetxattr(self->file_path, "system.posix_acl_access",
> > +                    buf, sizeof(buf));
> > +     ASSERT_EQ(sz, (ssize_t)sizeof(acl_a));
> > +
> > +     pthread_mutex_lock(&g_ds.lock);
> > +     count =3D g_ds.getxattr_count;
> > +     pthread_mutex_unlock(&g_ds.lock);
> > +
> > +     ASSERT_EQ(count, 3);
> > +     TH_LOG("step 3 OK: post-trigger getxattr reached daemon (count=3D=
%d), "
> > +            "returned correct ACL_A (%zd bytes)", count, sz);
> > +
> > +     /*
> > +      * Step 4: switch daemon to ACL_B (different size: 44 vs 28 bytes=
).
> > +      * Simulates an ACL change that fuse_set_acl() would NOT invalida=
te for
> > +      * !fc->posix_acl mounts (it skips forget_all_cached_acls in that=
 case).
> > +      * On a fixed kernel the ACL was never cached, so this is moot.
> > +      */
> > +     pthread_mutex_lock(&g_ds.lock);
> > +     g_ds.acl      =3D acl_b;
> > +     g_ds.acl_size =3D sizeof(acl_b);
> > +     pthread_mutex_unlock(&g_ds.lock);
> > +     TH_LOG("step 4: daemon switched to ACL_B (%zu bytes)", sizeof(acl=
_b));
> > +
> > +     /*
> > +      * Step 5: getxattr =E2=80=94 the decisive check.
> > +      *   Buggy kernel:  cache hit -> stale ACL_A (28 bytes), count st=
ays 3.
> > +      *   Fixed kernel:  no cache -> daemon called -> ACL_B (44 bytes)=
, count 4.
> > +      */
> > +     sz =3D lgetxattr(self->file_path, "system.posix_acl_access",
> > +                    buf, sizeof(buf));
> > +
> > +     pthread_mutex_lock(&g_ds.lock);
> > +     count =3D g_ds.getxattr_count;
> > +     pthread_mutex_unlock(&g_ds.lock);
> > +
> > +     if (sz =3D=3D (ssize_t)sizeof(acl_a))
> > +             TH_LOG("step 5 BUG: stale ACL_A (%zd bytes) from kernel c=
ache "
> > +                    "(count=3D%d); ACL_DONT_CACHE corrupted by "
> > +                    "forget_all_cached_acls()", sz, count);
> > +     else
> > +             TH_LOG("step 5 OK: daemon reached (count=3D%d), "
> > +                    "fresh ACL_B (%zd bytes)", count, sz);
> > +
> > +     EXPECT_EQ(sz, (ssize_t)sizeof(acl_b));
> > +     EXPECT_EQ(count, 4);
> > +}
> > +
> > +TEST_HARNESS_MAIN
> > --
> > 2.54.0
> >
>
