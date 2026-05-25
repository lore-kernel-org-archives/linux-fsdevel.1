Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D937DAA0
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711576; cv=none; b=sIm0qLworwRJS3lcrLg1WMyp/4uGH/zir747FE9V+xkLD8GxP+yIYPByITl9aX/CLd/Sq7OsxNkVv7CewLm73B+QVp+rtRMo9mOnIg5KY8se4YxBoJaqgYceZ7QQ1qagciIjidrGpAg1QGHUhq9WyS956B7KFsL5ty6caWyaNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711576; c=relaxed/simple;
	bh=WzPCO9gLDcbBMU5BoJ7zMH9AIATN2YIHyfy5SWW7xUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzoJLK3smB3AlLDWQYaN7F0tE6PPGiBsBWiYEaV/U912Ct3dDlWyMCI598+JsEQaiPiu+nm7P/ZK0EZKTVSIgNLqaRFXgSMOXCCrRfVUIJPfahU6vkT9WMbMcZ6iboLPlYOzthRvUJqCf1fhCb+Nurz1d4LyiflQbRCNOhCxtIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Tq9To+KB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Tq9To+KB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516df7b256bso11339731cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779711572; x=1780316372; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsSjlGTpZWL/2k9lFtJdhUdlf8UBtg09lUhGCMelAgA=;
        b=Tq9To+KB8YfL8kI8Q1HazS16sWFGf91j1TU5OwQJDq2l5iUEPsYYCZ0nWFmzgSoYuq
         jSzkLe8zsTLlOBv6K8omote5iyn3PcZu52TnaxcnVuTSyiTGkOEAgSoox2Xg2TcU5efd
         Da9xEBhlmIVWtEezPoTzB2Vh+nKQEJ6zPTeJLktEV8f96iicz1hf4HjRuAUR/3a9H8kj
         B+LB/dqZEyECCkz1VjfK35AQrQcFPDXoCyNmqKDYfHUSCMsMSrFthyQ+tU9wqHVEX2lV
         6YkFqFCFklE1VXrx7IsC7iaK09kkpg62GGeFsfW0GBKaKa737H44mBUCXsT60fUfl6To
         Jcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711572; x=1780316372;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsSjlGTpZWL/2k9lFtJdhUdlf8UBtg09lUhGCMelAgA=;
        b=c90qnNWvt6uVSK/W/ykXfrQSoHwfMHS2RxyM0+57S8cOKvNiqcr2ixApP9oJJJ7sql
         7dnjlAkjhybNYAZNrQi/7vcoTCLJWq9ub8IaN17/dk35HuC+eWIdsWm7/+HqINbw4/sZ
         vonrvFlERym6QxupORH9XO3EKPIBfo7ncCENwwlUAbHZE1K/sv8TwrFSeBBgjPu4/tql
         l63Gcf98IW/KkM8G3am4rzde5KrI838kYSNEeEL708WiYp0NOwoO3dusrh8jq234Uo9T
         k9gpXSqLhdIjx0L77t5mv7YZTRzBIQFus9BAHW/t5dwDyG9eq3HNrDjHJttgU8577j7a
         Jjdg==
X-Forwarded-Encrypted: i=1; AFNElJ+LtkriBSVNAdF2bYJKIcCJ/iRJBsxtQ1ha8fxkdLrY+trGV/9BIF7kuPqI1WJA8/YAnaMRGzTwgm0Zk1NU@vger.kernel.org
X-Gm-Message-State: AOJu0YwVn/se+U9U0AMTFo/mEAC1Hn6tCxoB3eyCD+WsPtxHMkfM2Dus
	hdNM4kSr/23faJN5TmMmsc+8xom+yqDILcuV6Jx/npq/UNRsus+B6TlPChFT6aQX5j4=
X-Gm-Gg: Acq92OHf6w73u596trDe5+9SYe4ZkkaZxHn2dhdWa+qidgeY7xBvE/myD9AhyDi7zvI
	elQKxZw91apFHfm63SVkvJbxP1N8IH651WK5yPVTEljp1Sxp0E4gUnOV+Y5b/xEisWE213o6QMC
	t9b0fmLWyL1wg2K73vmdwvmBASilozBSbOnAaBSc3Oo1t6rq8PVvKPrl3SDTXGORUdTjhRe3HLE
	HeD2LiB1SqtaX8N6kd1cpIJKP8QT6ZIMI8v+b3oFDdhC6rG5n7yYe/X1vxVorThlzn6+CaLy1DW
	5Vt6NF/odrUszktUu4s/33qyWIHkq+/ezN/AzldEHCFxN3aXqnyM8vVynfdqo6j7FHCZv6YQPZj
	gUwW4Lv41SaweTxr4vmbOVbXq1hS+rW4HKt9BmRJ/kdT8tCjItGf0YVOR9R0kmfd41nS209s3Ny
	mRcr+lllgaevlE5HHtOkQqw0A15nxNKHT5kgu/lrF3
X-Received: by 2002:a05:622a:9011:b0:50d:6b13:bb14 with SMTP id d75a77b69052e-516d436db29mr157358021cf.34.1779711571902;
        Mon, 25 May 2026 05:19:31 -0700 (PDT)
Received: from [192.168.37.1] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc81316d44sm107456886d6.42.2026.05.25.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:19:31 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: fix possible failure to unlock in
 nfsd4_create_file()
Date: Mon, 25 May 2026 08:19:30 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <D21CFD27-5D06-4CB2-AC48-B79F3C6A287A@hammerspace.com>
In-Reply-To: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
References: <177969022571.3379282.16448744624428323496@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25 May 2026, at 2:23, NeilBrown wrote:

> atomic_create() in fs/namei.c drops the reference to the dentry
> when it returns an error.
> This behaviour was imported into dentry_create() so that it
> will drop the reference if an error is returned from atomic_create(),
> though not if vfs_create() returns an error (in the case where
> ->atomic_create is not supported).
>
> The caller - nfsd4_create_file() - is made aware of this by checking
> path->dentry, which will either be a counted reference to a dentry, or
> an error pointer.
>
> However the change to use start_creating()/end_creating() (which landed
> shortly before the dentry_create() change landed, though was likely
> developed around the same time) means that nfsd4_create_file() *needs* a
> valid dentry so that it can unlock the parent.
>
> The net result is that if NFSD exports a filesystem which uses
> ->atomic_create, and if a call to ->atomic_create returns an error, then
> nfsd4_create_file() will pass an error pointer to end_creating()
> and the parent will not be unlocked.
>
> Fix this by changing dentry_create() to make sure path->dentry is always
> a valid dentry, never an error-pointer.  The actual error is already
> returned a different way.
>
> Note that if ->atomic_create() returns a different dentry (which may not
> be possible in practice) we are guaranteed (because it is only ever
> provided by d_spliace_alias()) that it will have the same d_parent and
> so it will have the same effect when passed to end_creating().
>
> Fixes: 64a989dbd144 ("VFS/knfsd: Teach dentry_create() to use atomic_open()")
> Signed-off-by: NeilBrown <neil@brown.name>

Reviewed-by: Benjamin Coddington <bcodding@hammerspace.com>

Ben
