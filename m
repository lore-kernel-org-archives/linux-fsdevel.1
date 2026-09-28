Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EB497B96
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634951; cv=pass; b=DDQCswbl3PdsLrOL8JC2mEE6HHDFEG0CKwDXEc+VMjOCdhvwsR0xmy3No65x9aDWwBQwGQsBuysWQjMClHayaVOO64saImDECT3J/wWiyPFtYYkC5eNTpzqhfIMPX4I6z1LXUv0traFexn6hdHh+jx2JOKFEzWIztifa/nJsfVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634951; c=relaxed/simple;
	bh=F1/l6OgOeI+x0F5SY6s6nggLxA7Jgat/gfQduPeGPdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NY+Wl7lDTriA9MTKyu5p27SaPsPDmia2iSTQmsynWhmK28bKVJFGaNA4LzzVbnmZ3iAP8IFubTPWY3MYNc2gtosLvwCP5ZYM6q7kveNolJeaxNjAUmmQp776XnKoG950U+lPQdu/Izi7jE1DXPuD2D9ZlMqITodVYx/48SNVYbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NR9L4Po3; arc=pass smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NR9L4Po3"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-88286981a36so1191838b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 15:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634945; cv=none;
        d=google.com; s=arc-20260327;
        b=TawYVnyh58pouG35mTTZ/hrEW2lhGlaPxtzCatHAqiOaF60op42EQEblgiljrE1jVs
         fvjMJZX75UBUd47yMmuuGhylCX3yaP93GUYhT8bmEnW32CSwUQhm9BceegeQ2qhgDZF4
         WHrqst2Z1q3HVG8BmS7PCPqRLACgmyX8lf9j3Sm7mGk6PJ4J6xWq3b8ItYqlPoJOZjBG
         JeCTadg9blIjrQ0wZshrSedR5eA4Rd3rE7Mt4T4wrbOxlTOZNS3aOXlPiTZjhSbSVfkT
         RTyYw+2CF+M4uWTtKlp99yJ9VYIed2fQl2E8Tjwcv/Z8fOGJaKfipHGifwrCycPIZRLU
         SorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        fh=sQcM7K6durJWHv6fmOnPEysPfJJtjJMcIU4HCiTug80=;
        b=XKfnHv4vH3uvKHiOSY1ZPIHMHChBETc5/F6FmntIrgJ5tj1y51pGJOOaHcSMUA9S0J
         97ouj5UzbxfNUSrR9mq+0pG+JJVV+X9imvsMFDUqubyApTdU/5IntTYPlKcFlcxNU25W
         EjJ5HhAEfLPQY8HnXwI5dXQi2oeSdhVtaiqu+MZZQn/5mDtcs1OfdZOIUugEDSngWtUz
         ifVwg3RWySzsEMVvba5IZ6oH4XvFo0CtW5UFNczm7xIZSrf5IMIt4rA440eb0zkmVSdF
         b8/qcWkPNjts9ubXQQwmlCy1j6IZ1eEbRZPOIPeSbTocnyLRb6uLKEMgTVtIDzE033vn
         oFAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790634945; x=1791239745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        b=NR9L4Po3vQXP6g0r94eMldHIKgCwIYPrRdJQnQ1cNlWDGR7VxPwpZwg/o6g2GknvXJ
         hZK8JlnEZuTB92E0nt2F5JPkm6hUyb6O6R3kA1XJwP460fF6JGF3VpXTu20xE23kWKw8
         8pEk3zibP3yIt7qG4RBLnHdmOVdeSyLO19mpVhKlg/lqQ1rm9OWLKdXEMkH7s2VihsFI
         C38y+dnqic6LoBy64Az19+bUju4piUcB8Ra3+ZHKU3IKqybzKR+9sjML3KZz7RxMxqLJ
         O+WtAOk6R1bvcX5MER3qRjQjdEGsydaLcKGSE51xmCN8Kv66/i3+4ukaKVOdVrJyi1A0
         Q9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790634945; x=1791239745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        b=mwe8u0AAF5zLlcUCAPn5unnNfAhkgHEhQ+H9TNnFKg79U1qoBTjRvrGL7Or+jtW95I
         JfWQfBHWuyX6dQxVWtowsg7a5kTcBj27O1ym8voA3TTo0eAlo0+gjsS+Gc4nzNuEkfNz
         fALsHmYETgjOn2U+9IY4BUP3yIdS164jY15uWLiFoxn3NV0hEg86bcv38/r9hukhRDat
         7cFgnKMgXVYzRMluabpFE6Bjm/DTvZPN+v3RbIOVhF46hIQvnNLlPDf/3GBbWGytVKSW
         LrlQ6sqjehXXaXmwaty6oNjzFSKOtGArQw/ZDWeYnl2geExMV/IMWpV6vTrPNjsgvVom
         0MxA==
X-Forwarded-Encrypted: i=1; AKwUvBz1BKL1F9aVbHCpgi75C+zAvHnKdJsn8WwoXvnolbZpMQukRrKWoGd8NTh+RMljrvg7Fy2iFxX1bw7viwwA@vger.kernel.org
X-Gm-Message-State: AFuF++muTEY9Xpp+HVIToryMGSQelGYRMf2NTECQsARdSnSpzQsdZ5X3
	LFojEetQnY3vebGCgjci5cFAK5rSr0iXr+nK2hoUCwSHON6SCTf3Y9xqiCaCIlATZH9LhthhzaC
	N8LSaJ5Kcrv72Hs+KNofVQbjVGh7xxCbQKOFHeIgj
X-Gm-Gg: AYBFou3h4ZkmRoc5di5yq9G9U7zrF+A+orG+NeQ5b4zw/NE85dQJDk+8uLOSHKFenmR
	i0uGzF9ilSXePCFo+7fZbPw9Q2Mko0zsigG/abHyGXyweXXL6bNUWfCgwemGYdGa1HcfJ7CakPX
	EDPF0B3axbaHDrugVV5WPxXZTx4MuWlBzPAqNpJPO7k5E1xxPH/CcY8Ta1Z+5M29nzZXTj7wtS1
	3yXMBiS5G0TiSknmowREN0lIC7GM+k2rUMwWPjDdcrUHej3T1iTSxj5aG9W3NpV0uVke1qus5Gi
	Zbk29L64RoksJVH/KSEFijZy7kY3DkqKzzrtQ0V7qyx0pV8OTdOXrpmTSNcFaabwBgYMrsDWf4u
	WkdekQqN/A5o=
X-Received: by 2002:a05:6a00:887:b0:878:3811:236 with SMTP id
 d2e1a72fcca58-87e9f82448emr11926596b3a.50.1790634944751; Mon, 28 Sep 2026
 15:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
In-Reply-To: <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Sep 2026 18:35:32 -0400
X-Gm-Features: AclHuK_FsGNbZ4FGUjZCK1Oz0frv6FIewmN7ZmvuDUc4wvtZdc4sm9Pj54ffJr8
Message-ID: <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:00=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Hi Christian and Paul,
>
> Thanks for your replies.
>
> On Mon, Sep 28, 2026 at 8:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Sep 28, 2026 at 10:13=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > On Thu, Jul 23, 2026 at 11:19:30AM -0700, Song Liu wrote:
> > > > Hi Christian and folks,
> > > >
> > > > Could you please help review this set? Does this set address
> > > > concerns from earlier versions?
> > >
> > > I just realized something while looking at this. This doesn't cover t=
he
> > > new mount api at all fsopen, fsconfig, fsmount, fspick, open_tree,
> > > open_tree_attr and mount_setattr. Without this the series is not very
> > > useful imho.
>
> Yes, I am fully aware that this does not cover the new mount APIs. I thin=
k
> those are orthogonal to the optimization here. This series is very useful
> without covering the new APIs. Users from multiple companies have
> repeatedly requested this change. ([1] and users requested this set).
>
> If we can land this set without covering the new APIs, I am more than
> happy to draft new patch set that covers the new APIs as a follow-up
> work. Therefore, could you please review this set as-is, and see whether
> we can land it without the orthogonal work covering the new mount APIs?
>
> > Thanks Christian.
> >
> > Song, I'm still open to reworking the LSM mount hooks, but any rework
> > should really take into account everything.
>
> There is another question here. These new hooks do not have any in-tree
> user at the moment. This appears to violate the "New LSM Hooks" policy
> in [2]. Could you please give more specific guidance on this?

There are LSMs which implement mount level access controls, you've
been updating those in your patchset :)  I believe that some of those
LSMs do have some (full? needs verification) coverage on the new mount
API.  I would expect that a patchset that adds, or modifies the
existing, mount hooks would also update those LSMs accordingly.  From
what I've seen, you've done a good job updating the individual LSMs
thus far, but if you have any questions or are unsure of what to do
for any one LSM, please ask and I'm sure the associated devs will be
happy to help.

--=20
paul-moore.com
