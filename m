Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F54E7815
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610364; cv=pass; b=Mz0oeYkHg4eW9beJvq02AL0ddYPI23/JFILYAr0m2e6cI66kUg7W+5DUouKIgqZ8MyCDQ6S/nfsXdrwkTzjXFlEvU2k2/NMjLzuNXMK5zyQOxcGhsjQ8vcRjGmaTejaGvOde9zFqw5C4l5puHXQzER/4RydEIibJg8xxMaljBtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610364; c=relaxed/simple;
	bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udpXG0daI/3GjOckdtKAeZCl+kSWNECqEf7ZXTCgmD0ZSkAN7H7MQgbghun5O9JE7EUrUfz1VdZ+OnKO+DC6jQJb48SO3gWmMu3u+woYlc79Os3cPcQfcSE66rCNlnzscARf7zR3ISYQGqnp+B0KxO0XKsA2/SO0Zp7fBxpr424=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PZkE7mns; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PZkE7mns"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db22383fe8so12364535ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 08:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610362; cv=none;
        d=google.com; s=arc-20260327;
        b=RWKNf3itjREfAZC/ZinLV4B60Up0QAzkCZgzNSKd7Zykpwk38Wf4UZN2993IvQuy6l
         lX1UzJcB00919y3jYYRoGDHYCHQynmC/9jqwv/hpAUAsLk9b8X/jiGbnJmMqKTB73N08
         Kf1wrDsa0myyOhx+57n5ie1c7Yw/9lN5/EZ3PSIwnSCixC3ULGNemunI+38AqaM4aqxA
         JY9gMTE90/s7K0tiUGkTjqw6gcjRGSdmahiI7ValAOg358tcXUDEgcyr+cd/wxctoIkp
         +qk24PBjnGfrzVkfl14LDA5AaQpYzg62Fy4m+BmnzKEv2iGS8wc2J8mP2Uj2Vnt/HlG1
         NcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        fh=rXoCNCdxGlWuWmD/4Iv7m+bDDGpPdcsou6yQC/dTjG0=;
        b=NlzEXhG4B9OwfFvEabaEhPZxUxbPpXD62bL7E/w09z0LLkOTOjFj9ZzuyCWJdEGJUA
         Ri8inlaXieCjcrLAv0r/kZaUSLtSiysxY4FIz9nFKvpFTbHnrzyrytw/J+oXbLyp5McC
         jwzIX9AeKs5ZavbseQsn3o/GnveH9wNAtc47wZq7yn0vLGaFAe0Oek4lHyKs8TPwar9y
         gLOsGWuLqfhXHKLTBz4vqgVvpcBqP3mEOBYRYaEQIx226wfufLOYJ1PRi6Cs1jD+Pkwn
         IGeQFzJ/ulqh3Qihz5A9/zRGUKOP5J+fEZ+kor36TY8oG1DsFBFmBJAE+MnU6MoNJ64d
         Llgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790610362; x=1791215162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        b=PZkE7mns5GW5YSJdiM4sHP9wLqDG0wjNCBVaNv/f1H42LCU3ckEHzDyt/hcRXIqX3u
         qnzHzpnevWwjBlMmObz/QnJvewjGZYIIXR5Bm8oOZ1JN5WLJEcWtxRSZO1CtdedFaes8
         SyZ59NGg9ElcTSlPYXrzILNXLHNg5TXNsTu14CdpmWp8VURrkPhacfnjRs6oMhQ6jDcL
         Q/A6FZxxToCesbOik6ViquOo6hPx61QdZ7+wjggVTcn7lXRR+ul+eiewXPH/r/9rQScZ
         yUsaY/PH7mo5L+tHOmStLz2qkw5soDulM86CKagVmIEEaUd17aQe3/lMjzaxVJ1VqlvX
         nXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610362; x=1791215162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        b=RGViaq5WGbYx2Cwq+lgegER3VNae+uwjUQp9T+XmacFYtVtfVwDeYZZzFRfm2fZGwR
         sLl5Tz59be7PecQmt723BiglLV9jLBTQ3/v9DYjXd3XP/R7Jsya3dSR08qZ/KiBGcYZX
         hYIkdLMfE0vYbv9L2eM/mZan/Qi2ufDBt4spELbYkHobMkonJj3JipeRVcBpwVTDnGCM
         vxvSFGNmXeZQ+GlljOAyPbpCT+APIaMQRGfWaOhXyI0GbnI8tUMNwQ+XmZMMRF/ahB63
         bE9Lc36ggk2Ps+a5VFNTuLzV/DHXpMpuakMa+W7hpNvOGFhucOaEHbjgDL1Hd7oOKRv0
         P6Lw==
X-Forwarded-Encrypted: i=1; AKwUvBzv7DsFdgxhuMXDfjDigontkUxsZQ71Qxz3sZOTgfoHrtyn12s1D/iYl2d7oatKkeerT7Uj1PxCpRfHDVU0@vger.kernel.org
X-Gm-Message-State: AFq9FYKV6m7K2IbfwooXZvqqW0MRIz+v5mj02PMRvD7VCz49T5CIrlqV
	63DHQogVNTh8MzYNvGXEzUL4qI1++ioCNjX+2ac2UX/gUrvlnA9Kj30kJABcf5rq8XvgDmyO5f5
	OrcWuB3QeG2RbMJ+ildQWrzzXrLYxnDD8BdnXQNJ0
X-Gm-Gg: AYBFou0XjfEUMOaLnxNnXiA0oifP9JG9Lpbbd6MA7lpr0d3dYODX0zUEEitZntaX0W6
	9t/ySvVlkhr50HU9a8tTtoVzFqbLuDcv60C7R4gdQOUJhUtS0exKnJ4PAxfl0Vj8lL3Uspw/m9N
	oZSNsxBJXavoGvp7EiuGrpZbJfhSSXMRn9K2+RmH6eh85hfhL4g45lW+EBpMMD/S9CjohUzYSvW
	kpJ50vailD90fKrosGKSay/p+DU4wDvF7G0bsfWlYYXdR9IRSp7eOhmJwn2lcnMuc6np8dGZ5xl
	0VhD9LagXUxr7Eaz9fkPxWQEb6mKdPU5McSuGasQrMoaUYS1xy2HKuG9E71/szTDJtlZttTG/QN
	wQHJUk8JbUCI=
X-Received: by 2002:a17:902:f70c:b0:2e0:8864:7f01 with SMTP id
 d9443c01a7336-2e088648100mr40903655ad.50.1790610361828; Mon, 28 Sep 2026
 08:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner>
In-Reply-To: <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Sep 2026 11:45:49 -0400
X-Gm-Features: AclHuK_fG4Ph2lyDB8B4vPRkrpFhgb007Hmd0WjDmDmNdvNtINrqpBqaiW-f0N4
Message-ID: <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:13=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Jul 23, 2026 at 11:19:30AM -0700, Song Liu wrote:
> > Hi Christian and folks,
> >
> > Could you please help review this set? Does this set address
> > concerns from earlier versions?
>
> I just realized something while looking at this. This doesn't cover the
> new mount api at all fsopen, fsconfig, fsmount, fspick, open_tree,
> open_tree_attr and mount_setattr. Without this the series is not very
> useful imho.

Thanks Christian.

Song, I'm still open to reworking the LSM mount hooks, but any rework
should really take into account everything.

--=20
paul-moore.com
