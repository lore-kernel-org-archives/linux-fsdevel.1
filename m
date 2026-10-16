Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D24E5342
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164594; cv=pass; b=rFRkfpRcIh7zHM73UXgLhxT5GVfYc37bLOHxbmlUWoL0nlEy5l9bMVstle9Ot6nPO9TVEHVfV7HT3g1lP6PTWAupspxZFtEqgsfOQde2y7eNKuvzBFqFk8WsdeEoYRn/5AUVweYTZH7t9hD21sU1lFJzy7InqCPYQ6goT3+T8Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164594; c=relaxed/simple;
	bh=JKYwIAWuEO4Fdpw/MxbYoMyckJMChKRc7N9CbueXOIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMOE7DWVDS905q2lJS7V0PgkKS+6c+Cq1t2HNWpUVtStzzrxdYcP/rgy2ehZQQCZkKJdUwSJ4lXDOPye6ASxGh5ir47Mgq70mzGh9iSyv6tRsjmaZQtNgZL9Gtem6kr0MUxTd01fHRD7dQDMXzN/+A/xLxqsSp8X1NX1OziKJn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFiqM93Z; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFiqM93Z"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso6456809a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 08:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792164590; cv=none;
        d=google.com; s=arc-20260327;
        b=a0EApEeIdqQqjI1HNYxpaCL5AZ6RKDkVaOBZi4Qo4NSbaz8oH1JosNuud3bNeXNEUW
         uvLQ5N+79Addjn2/gsf1NMR7qgOtERFoXLllGCRK7UWVdB1appC6VqdRdDaGi1++5aOD
         a+cTiczxYORjheBKe8aRiNsloM8VEJYc9vdgJec9fi//FtQYcZB1S53ffaLLXWgzPE0y
         q+N9k/Imi5BS/sDQmY4JmfQir0JdLxWS+y6y9KFxx6a7FM2hDTvSMxGKp2uX2HagggiX
         y6i9V/w9xI5VhHTGZtVQTvMWASAAL41fnQAMuIjOWrOerylZE+Ia3rUuj2BgXSORkZKS
         l3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GzxCTLXZVWb1sztadDq28zCG+50J58vjQyR4GrqxYug=;
        fh=+iOwOEbYjHQs4qi/VXgt9CRQA60vvkoaUxROYJ+V99E=;
        b=EOcdqhUjcZTPlZI3dgNo3h0QMdmI3fb41hN7A4FL/5S3iRv8QXerrzFh1R39NkC0ka
         0w/uG/suoLtZiTh75Avf6Ow8dIIKVaAUBD5d7exZ0kuIvt8Yeh+xmEFw6ml0iCxeTAXO
         aegB5NYMRwPhfouhzZuRdwevvrVJcds943yLXvR+bRloUIhgkDoDqF472+5OGKGDzUOI
         FXv05tvmS9hywD4+VzwiIIoROC3gO7PmK+tDaQEnSaaTwgmpH3VLWcEg4Swz7sVWgkhw
         KlKEMN7U9b6Y0OgHCRovRJTU9Vu9QjcEZhjbb4jf6KCSf+YrzGZQvh5ntbwc4ctwElGm
         NdrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164590; x=1792769390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GzxCTLXZVWb1sztadDq28zCG+50J58vjQyR4GrqxYug=;
        b=OFiqM93ZCLlXRKY44x9U7OTh3RRe0V6EResUzopNGgheVu98sJJnlUfU1F/psk8phD
         3t3obRICfkxuJLESf23c64jKNyDycpgomiBJ9leu9XUnYbbtNsPOjwagA2qzyJlxsHSt
         wMN25rrNAftvtP/uaWMXn0HmmZS2udyLp5q+iOMNpCcNvsDEGPVS1jgq34N2H8EW4u6L
         Zdm9qqZPj4ctkOI/xuY3WGHRNjPEMljH1NSYn8N3GGbrgiGyqH583geNiIW1EBc/teRf
         nsPeP08JGqKpK9Ggma5Pcg58zT7gSbx6ActpHtgwhvKCPnNmb5hIqgM/DYlLxvP8Ye0A
         6S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164590; x=1792769390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzxCTLXZVWb1sztadDq28zCG+50J58vjQyR4GrqxYug=;
        b=r6GmECtVKewhJyQjbHiqEXtl7eZaIJ7m+2+0JvMQXvB8+vdIVj5l5Bqk3B8pTfO3Oq
         xCq+3S00+zali2P+MEHhermbzO9CT5jnCks6ZD+0jon3Fd2dx+8QUEcL7MkXDlpAsQ6H
         EgZWWhxLXnsEZRjseCKQ0MIqdV0G1EawP8e6IBBC2/5+uL4k9tPXw2R4vnfew4QIV/RW
         MC1K8RF3SH8PSDzEnD+0K2ihvS5NMdAKlogBaI1ofpzRQJOZ7FDtkJiydLZMSqR7Tlav
         OKYTV7o39MA8Ykg2QKXaGTH3SLab55KgqSNVaNZ/3gT6bzcMc0zAOODrMHrA7fbyHUcu
         pBog==
X-Forwarded-Encrypted: i=1; AKwUvBxU6TsMbD3a5RW3u53bczmEg6YW+K47PgrPSfkOm2PlfQxw9aY9TMFHIJdgzcHaa0EF28yaoTV22xF2e+eQ@vger.kernel.org
X-Gm-Message-State: AFq9FYLMSvMPSH4SF7FHr+mmfW5I6j1iXHa3kioT70Ose/Q2CnBid7vI
	3D1YkDnbpXXbHxFkBNmK9UhpkQx9MCoBR4YI+S0fqNeywH+wkWGkDBKU5H4cAT1y/RG5zVOQAvj
	zRHX7xqMh89LW/YUpM8DTRfmIzygPEJE=
X-Gm-Gg: AYBFou3ST2vys5dpc468K+iQtoPtEwEgbM0MR2Ty7hLsJ1x7BHpa8lduaeB2LDkhfu8
	F6vPcjoPWQ+jwLsdc12AHHPjbSQHIgN/zngpkyfARj5JJ2mLvfPs+gelY/17i9+25+GnG35JESF
	j747pICQv3KteqtzO9Z3WMSAqdxvUwVhMq0hzODsWLJqpIdx6kH6Ob7zsW5juppzPrEqA8a1tg3
	fCH5qUU3p9oPNJeoN9/Am+xx//aArcyC+8lsqIjYP79emCtGaHitu8gQXLi/P0kJn4RU9jfskSg
	rZbccv1ZNOW5/BWoqu8A7CLCjZFanlwo3mG2kksKebhX//pXRknapxij
X-Received: by 2002:a05:6402:2115:b0:6a9:f88d:c092 with SMTP id
 4fb4d7f45d1cf-6b17c164de5mr18251328a12.0.1792164589590; Fri, 16 Oct 2026
 08:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924112858.51392-1-disgoel@linux.ibm.com> <20260924112858.51392-2-disgoel@linux.ibm.com>
 <CAOQ4uxgj3RL2roivmha9yeWToR-s9kaBm8WUK1vJ_q7pWOjxOQ@mail.gmail.com> <95790639-84d0-4cc2-92a8-c97c920b2d22@linux.ibm.com>
In-Reply-To: <95790639-84d0-4cc2-92a8-c97c920b2d22@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Oct 2026 17:29:38 +0200
X-Gm-Features: AclHuK9GCD3mbn9wIGFBZNK990RRcALNugyHWGuR9k1nQAaxajqzHCCrTNtnk_A
Message-ID: <CAOQ4uxh2yMYuzjJbmnw3eq-0b-nmmb4J=6zhJcVuHaNHUN3YBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: fix wrong layer paths in mountinfo for detached
 mount FDs
To: Disha Goel <disgoel@linux.ibm.com>, brauner@kernel.org
Cc: miklos@szeredi.hu, viro@zeniv.linux.org.uk, jack@suse.cz, shuah@kernel.org, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 9:22=E2=80=AFAM Disha Goel <disgoel@linux.ibm.com> =
wrote:
>
> On 25/09/26 9:27 pm, Amir Goldstein wrote:
> > On Thu, Sep 24, 2026 at 1:29=E2=80=AFPM Disha Goel <disgoel@linux.ibm.c=
om> wrote:
> >>
> >> When overlayfs layers are passed as detached mount file descriptors
> >> (opened with open_tree(OPEN_TREE_CLONE)), ovl_parse_layer() uses d_pat=
h()
> >> to record the layer's path for display in mountinfo.
> >>
> >> d_path() walks up the mount tree to the process's filesystem root.  Fo=
r
> >> detached mounts this walk stops at the anonymous namespace root instea=
d
> >> of the real system root, producing a short incorrect path like "/l1"
> >> instead of the full absolute path.
> >>
> >> Export mnt_is_anon() from fs/namespace.c to detect detached mounts.  I=
n
> >> ovl_parse_layer(), use dentry_path_raw() for detached mounts instead o=
f
> >> d_path().  dentry_path_raw() walks the dentry chain independent of mou=
nt
> >> namespace and returns the correct fs-relative path.  The path is
> >> display-only; the actual layer_path used for mounting is always correc=
t.
> >>
> >> Also fix the set_layers_via_detached_mount_fds selftest: the mountinfo
> >> check strings were copy-pasted from the regular (non-detached) test an=
d
> >> expected absolute /tmp/ paths, causing the test to always fail.
> >>
> >> Fixes: a08557d19ef4 ("ovl: specify layers via file descriptors")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> >
> > Disha,
> >
> > Thanks for the report!
> >
> >> ---
> >>   fs/namespace.c                                |  9 ++++++++
> >>   fs/overlayfs/params.c                         | 14 ++++++++++-
> >>   include/linux/mount.h                         |  1 +
> >>   .../overlayfs/set_layers_via_fds.c            | 23 +++++++++++------=
--
> >>   4 files changed, 37 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/fs/namespace.c b/fs/namespace.c
> >> index ae5dc64f8b45..9feefa0a517d 100644
> >> --- a/fs/namespace.c
> >> +++ b/fs/namespace.c
> >> @@ -363,6 +363,15 @@ bool __mnt_is_readonly(const struct vfsmount *mnt=
)
> >>   }
> >>   EXPORT_SYMBOL_GPL(__mnt_is_readonly);
> >>
> >> +bool mnt_is_anon(struct vfsmount *mnt)
> >> +{
> >> +       struct mount *m =3D real_mount(mnt);
> >> +       struct mnt_namespace *ns =3D READ_ONCE(m->mnt_ns);
> >> +
> >> +       return !IS_ERR_OR_NULL(ns) && is_anon_ns(ns);
> >> +}
> >> +EXPORT_SYMBOL_GPL(mnt_is_anon);
> >> +
> >>   static inline void mnt_inc_writers(struct mount *mnt)
> >>   {
> >>   #ifdef CONFIG_SMP
> >> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> >> index c93fcaa45d4a..2758ff8426b7 100644
> >> --- a/fs/overlayfs/params.c
> >> +++ b/fs/overlayfs/params.c
> >> @@ -477,7 +477,19 @@ static int ovl_parse_layer(struct fs_context *fc,=
 struct fs_parameter *param,
> >>                  layer_path =3D param->file->f_path;
> >>                  path_get(&layer_path);
> >>
> >> -               layer_name =3D d_path(&layer_path, buf, PATH_MAX);
> >> +               /*
> >> +                * For detached mounts (open_tree(OPEN_TREE_CLONE)), d=
_path()
> >> +                * resolves against the anonymous namespace root and r=
eturns a
> >> +                * short fs-relative path rather than a full system pa=
th.  Use
> >> +                * dentry_path_raw() instead, which gives the path rel=
ative to
> >> +                * the filesystem root regardless of mount namespace. =
 The name
> >> +                * is display-only; layer_path itself is always correc=
t.
> >> +                */
> >> +               if (mnt_is_anon(layer_path.mnt))
> >> +                       layer_name =3D dentry_path_raw(layer_path.dent=
ry,
> >> +                                                    buf, PATH_MAX);
> >> +               else
> >> +                       layer_name =3D d_path(&layer_path, buf, PATH_M=
AX);
> >>                  if (IS_ERR(layer_name))
> >>                          return PTR_ERR(layer_name);
> >>
> >> diff --git a/include/linux/mount.h b/include/linux/mount.h
> >> index acfe7ef86a1b..51e9f228c9d1 100644
> >> --- a/include/linux/mount.h
> >> +++ b/include/linux/mount.h
> >> @@ -78,6 +78,7 @@ extern void mnt_make_shortterm(struct vfsmount *mnt)=
;
> >>   extern struct vfsmount *mnt_clone_internal(const struct path *path);
> >>   extern bool __mnt_is_readonly(const struct vfsmount *mnt);
> >>   extern bool mnt_may_suid(struct vfsmount *mnt);
> >> +extern bool mnt_is_anon(struct vfsmount *mnt);
> >>
> >>   extern struct vfsmount *clone_private_mount(const struct path *path)=
;
> >>   int mnt_get_write_access(struct vfsmount *mnt);
> >> diff --git a/tools/testing/selftests/filesystems/overlayfs/set_layers_=
via_fds.c b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fd=
s.c
> >> index 7a293544233d..12d930fe46be 100644
> >> --- a/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds=
.c
> >> +++ b/tools/testing/selftests/filesystems/overlayfs/set_layers_via_fds=
.c
> >> @@ -686,23 +686,28 @@ TEST_F(set_layers_via_fds, set_layers_via_detach=
ed_mount_fds)
> >>          while (getline(&line, &len, f_mountinfo) !=3D -1) {
> >>                  char *haystack =3D line;
> >>
> >> -               if (strstr(haystack, "workdir=3D/tmp/w"))
> >> +               /*
> >> +                * Detached mount FDs are resolved via dentry_path_raw=
(),
> >> +                * which gives a path relative to the underlying fs ro=
ot
> >> +                * (e.g. "/u/upper", "/l1") rather than a full system =
path.
> >> +                */
> >> +               if (strstr(haystack, "upperdir=3D/u/upper"))
> >>                          layers_found[0] =3D true;
> >> -               if (strstr(haystack, "upperdir=3D/tmp/u"))
> >> +               if (strstr(haystack, "workdir=3D/u/work"))
> >>                          layers_found[1] =3D true;
> >> -               if (strstr(haystack, "lowerdir+=3D/tmp/l1"))
> >> +               if (strstr(haystack, "lowerdir+=3D/l1"))
> >>                          layers_found[2] =3D true;
> >> -               if (strstr(haystack, "lowerdir+=3D/tmp/l2"))
> >> +               if (strstr(haystack, "lowerdir+=3D/l2"))
> >>                          layers_found[3] =3D true;
> >> -               if (strstr(haystack, "lowerdir+=3D/tmp/l3"))
> >> +               if (strstr(haystack, "lowerdir+=3D/l3"))
> >>                          layers_found[4] =3D true;
> >> -               if (strstr(haystack, "lowerdir+=3D/tmp/l4"))
> >> +               if (strstr(haystack, "lowerdir+=3D/l4"))
> >>                          layers_found[5] =3D true;
> >> -               if (strstr(haystack, "datadir+=3D/tmp/d1"))
> >> +               if (strstr(haystack, "datadir+=3D/d1"))
> >>                          layers_found[6] =3D true;
> >> -               if (strstr(haystack, "datadir+=3D/tmp/d2"))
> >> +               if (strstr(haystack, "datadir+=3D/d2"))
> >>                          layers_found[7] =3D true;
> >> -               if (strstr(haystack, "datadir+=3D/tmp/d3"))
> >> +               if (strstr(haystack, "datadir+=3D/d3"))
> >>                          layers_found[8] =3D true;
> >>          }
> >>          free(line);
> >> --
> >> 2.45.1
> >>
> >
> > Christian,
> >
> > I confirm that the test is failing on upstream:
> >
> > # Starting 1 tests from 1 test cases.
> > #  RUN           set_layers_via_fds.set_layers_via_detached_mount_fds .=
..
> > # set_layers_via_fds.c:717:set_layers_via_detached_mount_fds:Expected
> > layers_found[i] (0) =3D=3D true (1)
> > # set_layers_via_fds.c:39:set_layers_via_detached_mount_fds:Expected
> > rmdir("/set_layers_via_fds") (-1) =3D=3D 0 (0)
> > # set_layers_via_detached_mount_fds: Test terminated by assertion
> > #          FAIL  set_layers_via_fds.set_layers_via_detached_mount_fds
> > not ok 1 set_layers_via_fds.set_layers_via_detached_mount_fds
> > # FAILED: 0 / 1 tests passed.
> >
> > I could not find a point of regression.
> > Could it be that the test was merged failing?
> > That would be strange.
> >
> > This is how mountinfo of detached layers look like on upstream:
> > / /set_layers_via_fds rw,relatime - overlay none
> > rw,lowerdir+=3D/,lowerdir+=3D/,lowerdir+=3D/,lowerdir+=3D/,datadir+=3D/=
,datadir+=3D/,datadir+=3D/,upperdir=3D/upper,workdir=3D/work,uuid=3Don,meta=
copy=3Don
> >
>
> Hi Amir,
>
> Thanks for looking into this!
>
> On my ppc64le system (7.3.0-rc4) I saw dentry_path_raw() giving per-
> directory names like lowerdir+=3D/l1, upperdir=3D/u/upper etc., which is =
why
> I went with the kernel fix. But your observation of lowerdir+=3D/ for all
> layers is a valid outcome too depending on how d_path() terminates.
>
> You are right that the test strings (/tmp/l1 etc.) never matched
> detached mount output.
>
> > Whether the suggested solution is what we want for it, I am not sure.
> > I also don't recall if we discussed this at the time and whether
> > there were any decisions about how to present this mountinfo.
> >
> > Maybe this mountinfo is fine and then we only need to fix the test.
>
> Happy to send a v2 with just the selftest fix if that is the preferred
> direction.
>

Hi Disha,

Sorry for the delay, you caught us just before traveling to Plumbers.
I have applied a patch to my tree to fix just the test paths expectation.

w.r.t the regression of the override_cred feature and test case
set_override_creds_nomknod due to commit
c28f922c9dcee ("clone_private_mnt(): make sure that caller has
CAP_SYS_ADMIN in the right userns")

I am still not sure what's the best way to handle this yet.
Will wait for Christian to chime in, but I don't expect that to happen
during the upcoming merge window.

Thanks,
Amir.
