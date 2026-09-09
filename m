Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DFF5476CC
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953517; cv=pass; b=trJm1LykfLbmlWyalMXrgEzyrEp7rZIsPLh26krijcn1teG+wGjvEUmYfQUIXqXbCpPXF/6JtMtp/6Z6M6O7rNaXJaOf7gqvoMOA96xIjIoJ8AhRjFt+SMu+lYiJb/v8GPRO26kFZITRlZsiRsU9uQ6JksEXogPSrCBHSQCrN4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953517; c=relaxed/simple;
	bh=5dfVrJoxl/aakjjCR9muNwRvZcP5yB39nnIlMDaXRj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhW2rtBEH9bgvGeGF0uUsYcWdX7oIV9bFwJ7J7gUZUko6idxfE7reT2+PyMyeaVF9VlDqWNdGyXaigZKn3gcXz8h/cDuul6W4Iye3j8vmC7MketFut0c4FI2gPJyhJQmrsheIRyKXSYs5ZSva8IDtzjxQgiiJg8vdb61H2BX9e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=fiPhn8SI; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="fiPhn8SI"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67109e0aa0eso396018d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 04:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788953515; cv=none;
        d=google.com; s=arc-20260327;
        b=JYl1Ru4IBVpcIkhQ1P364mVMYx74PHlFJ1BbFnRN1PAWE4xB3pdjM0kD17leJWlrGq
         jkCb/cZN2pzb14/GMlnpdPtN/f9C7USotDVemCYfGrP+dkaYehPT/szacl+rA9JcLJu9
         o+r8IsMvqCqBbbgtIwz4wEn+X+JMn68kMTd709MZ5UFamstriAIjwwHpV2z6Iv+VGOp1
         mMy242yYL6xGfWkG3PaxV5ZxkczqT941pjSsWJDnFQglu7QOe/WFAfG1M0Mld9C6vmq1
         3FwW6ZNTFkV1FK0sLRD1fsQPkN883DuCJjuXQfjfMbgPlDFoN/15PSUWjc2zR2s1zp1Y
         E4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PNU9Cs2GO/4YNQLjDLGYHiHc9eZguxtceoLERV9Q/wI=;
        fh=fjGSQriUYUGF/f7NlMTWvHIMxVudoJyqhlzxoy/Im9I=;
        b=sDGGWbrT0C4bp5M6lv3LF0qAuY6bT1I72RBxhLfIyzHICx9VVTBuH+mf86nKuF9MLp
         DyvumqguQ4p4mDwO9p7tYTvgHWcBgDTrFLtzDAJeo8p7nWYLvZwvQyQf1d8AsuRLh4oS
         45boeAMyai9dgOuObbaCZiy7mLnMcwaLekEjI70ZeNADhT4CqpYeHRsa517xY9mpbpiU
         c/QVjisFsLJwP8NIytdBN/cGJ/ST/wO6NiFAL6p03QSAklNtfPb7us9uSP2X8ZAYEDdz
         g8ZP/JiYCXSYSMqnL7a2L6fr7dZ8zDlrj5CdBAdLkYlxrnxzks6SE50pWfoSTnkUHeuY
         dOdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1788953515; x=1789558315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PNU9Cs2GO/4YNQLjDLGYHiHc9eZguxtceoLERV9Q/wI=;
        b=fiPhn8SIEYYssES90by9unrp/Ce7chBmnNyLNvlr/a7asm3iIJOzdYarZuKcoFtbEI
         lC9AA1FJ3JUIKRw5+LfWV89CXEcpirli76TmMDluvacxv1b2xXRhxm+KV6Bf2dT5ft5G
         9UJmQeTNyoB4r/rJKfKY4S8l45nWwCS05g86kD65L3JpC/JEbEBulVkOYIK0+jH9DBay
         XrC1X2sLEmORiwwM5Apk4sgIm/LqKkj+JCANIak9OBozFHBprfiQiRg6FpC5sEkgqUuX
         nZ1ZqlIiWrsG6DroC/sCu+YKUqqn933ETmf1lN7rei+pWl2wBqUPbIy7MvAYpJL/HRuR
         dnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788953515; x=1789558315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PNU9Cs2GO/4YNQLjDLGYHiHc9eZguxtceoLERV9Q/wI=;
        b=kyCQ40iiwmnemhtYuo9sGf21PQsuAByR+NX0ZP+DxxWLXtSXFqz44dOlmouQV7ZpNO
         0MjbTuMzftmTR+j4opZtTHTR8s/+B7G8doZSiwf/rg1j0YWmiQD1X4vpQbMoCl39M26V
         qz7LT5zxnYhCPrBxRagIU00D7it/RcSsjgsU89q6o8Blx/10uU/+hH3AVWGaH0V5IH9D
         z0Svq8UgZagO3YIxQA3jktXwlEouG71KD57EoZh+7JzfkvJTOWLB30BNMAUvGbXo9Tli
         MWNoSCry9SmEFL14/UOQ1lBGMYhGB+z+IWwcS0cfHhFxg1KFW3f60JXL0vkT86qLCgKN
         1cRw==
X-Forwarded-Encrypted: i=1; AKwUvBzS6UlBj+Ccr4+ZtUufjvBF61dkir6QK7y60TQuhPC+4wflq59COTCc6u113HkXd56Vh7eBoLBSuZXD8qKD@vger.kernel.org
X-Gm-Message-State: AFuF++lDC6UhhtW2Hf4MWBww1Tso4SiwpBMyAp0VqQ614e7J4xx3/W1K
	gkEd8vcMnXy5isF6Y+Z42IDW4SIacN8wVxbCGM94CgDt/zVxaqhvE4w/qt4cDdNFaE1TcTvpOPA
	GFWTGJVBI3YlfkeYk6u5CuNXbahIQ+MuedsqSxqDlDHkGbBaCQD1MtzcR
X-Gm-Gg: AYBFou2stJ63505OtiQf/LFeNKRvYnUvhnuDeKWvfgNsXwhfBRHBiU+mOB/pjTm4LIF
	OQF6uggZ1GV0UFKglLBeNJRQmjelQqDWeE9o1YRbRKi7MUY+MhkpGhUTgd+b2jGUka8pUQCb64x
	GrXwtIPpEOX/POXlT8+3G2j1NDnwYMLpvMy9GOX62QxItEHFqf1zJGGvfQZTgLIiOz8TNCFcwer
	elzdGE3tMwKmhKEcTuoCRXIRQks+9+5tfslZ4+0ldz/uDFJ52BIhNcklOFJhxG9DIeokV1jXR5j
	+6Jpf/TTw37Ngru/B8CB863kFu6YxadsNBw3TkeZcYlpm5vJzcHoT+haJXcDlsbyXw6tSSi9+D5
	Nq6/51LBsPLju+DuzbWkf/eQj
X-Received: by 2002:a05:690e:4888:20b0:66f:beb9:b1b4 with SMTP id
 956f58d0204a3-66fbeb9b4admr1905952d50.35.1788953514392; Wed, 09 Sep 2026
 04:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-1-920a1963675d@amutable.com> <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
In-Reply-To: <CAHC9VhS5q2=6p2bi5c7CZ3mutji1xiKR2eFKgJ9C+XZsYgky2g@mail.gmail.com>
From: Daan De Meyer <daan@amutable.com>
Date: Wed, 9 Sep 2026 13:31:42 +0200
X-Gm-Features: AcwNN1WF5wnirz-p9XhAjdbRh2yyDynGRgpa6C1inpir3KV7AQr5BoXmZV6UDsI
Message-ID: <CAPa8sAgVFXz4ZX-OR3YoRM3cOSqL613NnpWfgsbKiPjViOziBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: expose mount idmaps to inode hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> As long as you are okay with me updating the patch with the change
> above (and explicit on-list email would be good), I can swap in the
> paragraphs when I merge the patch so you don't need to do another
> respin.  However, if you would prefer to do a respin, that's fine too.

I'd be grateful if you could swap in the paragraphs, thank you!

Cheers,

Daan

On Wed, Sep 9, 2026 at 12:05=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
> <devnull+daan.amutable.com@kernel.org> wrote:
> >
> > From: Daan De Meyer <daan@amutable.com>
> >
> > Pass the mount idmap through the create, link, symlink, mkdir, mknod,
> > and permission hooks. Update the in-tree security implementations and
> > non-VFS callers accordingly.
> >
> > Signed-off-by: Daan De Meyer <daan@amutable.com>
> > ---
> >  fs/cachefiles/security.c      |  4 +--
> >  fs/namei.c                    | 18 +++++++-------
> >  include/linux/lsm_hook_defs.h | 23 +++++++++--------
> >  include/linux/security.h      | 58 +++++++++++++++++++++++++----------=
--------
> >  security/security.c           | 40 +++++++++++++++++------------
> >  security/selinux/hooks.c      | 19 +++++++++-----
> >  security/smack/smack_lsm.c    |  9 ++++---
> >  7 files changed, 100 insertions(+), 71 deletions(-)
>
> Casey, are you okay with the Smack changes (below)?
>
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 8e88ac65fd7f..a45819d13c0d 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -1089,14 +1089,15 @@ static int smack_inode_init_security(struct ino=
de *inode, struct inode *dir,
> >
> >  /**
> >   * smack_inode_link - Smack check on link
> > + * @idmap: idmap of the mount
> >   * @old_dentry: the existing object
> >   * @dir: unused
> >   * @new_dentry: the new object
> >   *
> >   * Returns 0 if access is permitted, an error code otherwise
> >   */
> > -static int smack_inode_link(struct dentry *old_dentry, struct inode *d=
ir,
> > -                           struct dentry *new_dentry)
> > +static int smack_inode_link(struct mnt_idmap *idmap, struct dentry *ol=
d_dentry,
> > +                           struct inode *dir, struct dentry *new_dentr=
y)
> >  {
> >         struct smack_known *isp;
> >         struct smk_audit_info ad;
> > @@ -1226,6 +1227,7 @@ static int smack_inode_rename(struct inode *old_i=
node,
> >
> >  /**
> >   * smack_inode_permission - Smack version of permission()
> > + * @idmap: idmap of the mount
> >   * @inode: the inode in question
> >   * @mask: the access requested
> >   *
> > @@ -1233,7 +1235,8 @@ static int smack_inode_rename(struct inode *old_i=
node,
> >   *
> >   * Returns 0 if access is permitted, an error code otherwise
> >   */
> > -static int smack_inode_permission(struct inode *inode, int mask)
> > +static int smack_inode_permission(struct mnt_idmap *idmap, struct inod=
e *inode,
> > +                                 int mask)
> >  {
> >         struct superblock_smack *sbsp =3D smack_superblock(inode->i_sb)=
;
> >         struct smk_audit_info ad;
> >
> > --
> > 2.54.0
>
> --
> paul-moore.com
