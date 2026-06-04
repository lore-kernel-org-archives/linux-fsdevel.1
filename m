Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF23E3C50
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605006; cv=none; b=mRIBZqJAlC1d0ptSa4Hp16hiIWl4a027k597Q04Crx2PSbCBh3pYcBbI1nubS4fZ7KFKToGGmrMvYIFyevp8WLllBv8Ds4PRxcEOXXWbvow7quTlzA5wICb6szYvd5yiENaCvzYxXViLkw1GVd6NUyopPAd4IlIwe1qffgV+P+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605006; c=relaxed/simple;
	bh=E0eGepHGYQKUs/ko84r1foShV2m+ylziZzZEGSZpoDU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=BHqJxP8gXr/mVBO3+xY31TpLrVfJz8VBlgBxXcslsy+6bSi9mPgzZ3p8U2vXySTvzpBZPa41dJFZ+WEEqgmgYWH98Yo0xd/FlZJtpFEGp3QmqzW0HVEitZBdaNixntCBkeZDU6LU1Z2yBAyIqQJfNpy33irwKftMGrKkWiSQ5SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddf+k0hn; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddf+k0hn"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-137f3cb3f46so2076422c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780605004; x=1781209804; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAOEJySs55fRy0cpkhY9pn8i73FB5zhFcaq9qMjLuIk=;
        b=ddf+k0hncXJhLPD7sBPCrsmhPKjUXEPemrFbb3aX320i0+V5OmxqvLX/6bRkj1f9Y4
         5Y4/qDsl2k+bf9E68w/C8tjTSAExG8vkl3Sxu0IlflKP1BLNF2A2lCf7eoei1vSUP+uy
         Bwnyy3TPBdL7pR+bMdnyDN1VvNaIZ+MkEuwqQ85ip45t4FaBe14Qh6eXDBJbJopZZH15
         D2PWVXEuhZTHAhH2/XPVOTEElhmQq4n5ZRlJEW2MGPphdU88mMXbFI+82huUJC7VofI0
         p2VKGLP+LiJBgA0A2uTAJx4ZkOPr/SgRuk2fVl8ivoZfNxkN0fl5uc55Ot9KVZBaU6PL
         wQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780605004; x=1781209804;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAOEJySs55fRy0cpkhY9pn8i73FB5zhFcaq9qMjLuIk=;
        b=S/GttMRA4MY6b+/Iz62UovI3MxlOTu/xVBataN0y34GB7fX4aLBo+KM+VQLgJKx898
         3Ini2+5MjimdinicO4IlQtpYN7Xf5umXqzCB+lsRl8m6g3dTOGDf6DI2Pg8BkAXimZug
         GhU5kYMCBnQzj0C41/iO5LjpZlTDTdaW5RTs971S4xf0cth3Xyu69EanDPKwLfLqvznd
         xc4CA/E92Oy8x9COlNLB3GLF6JnztG11pwQu6qCfsxdWB/6BzE++MA0Ccbul5bOzYp2a
         qKZ5VJDDQD7lzaY87825bOxknWymzVdubWBnK8j081KokCTZDyHyVAHzGE42uj9JlTvx
         4P5g==
X-Forwarded-Encrypted: i=1; AFNElJ9GlNT3kEiwHsyQ1fvTY74TZ/SJ7qDmUite1pn7eOWhGfOKmNdIs3KWsa0GEU7qpQs5Ylv1kMl1XVtxuje9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xmNEO7+9o9l0ky/rXHKNmT0mwuy0OigXCyla8YD7CvIKUug8
	LX2cv8B02r0u6Z6OcKxB75D89CNtEymkUj9apHfkrLplrN7YBQ0wnaB9
X-Gm-Gg: Acq92OHh+JCEZeBXDL/zYlOdet8NeG5tIghB217vR4J4zRhs1TOwWpPodzKhkTZUd0R
	AXLKtO8b4AweRPKcAiTrwRYVcOTYHfAZCNO6LfYnJvzC/EXe8v0p8wAZclX4QXD06wxG0l4Lbmw
	DR5i6X5HP2foQM0MezGON+qafPAcS0It1wLaYS97Ad+jRJ6KEybu1HPj/2tVhy29iQ3na/DzCBo
	gid0IjGDsmUX4frZEuYHC86I2CHy+O5UDEiQr/TXmR0DnPtFMLVMPD9+DKrBgwjY4tOJZevtkvQ
	jZqMWCRFNWoaIRJFB478EhXOAqDZ7/+PUbnvPYeKruI2dSzZ/xwb7jIMuZ52iHnjBBRl+rxkpbH
	9kxbtwaxcuPdYMck8ZZWMQOJUcjP+IEwExE2OYavaf3NQJtCNu+djGngMqxS5ZKvzZtaHiZ7bwV
	zJV5yBSRaQmuMW7MNBv8uzpHDJeYc8PlcdUYuBtJ0=
X-Received: by 2002:a05:7300:f193:b0:304:de28:1b16 with SMTP id 5a478bee46e88-3077b7830aemr158595eec.28.1780605004426;
        Thu, 04 Jun 2026 13:30:04 -0700 (PDT)
Received: from [10.61.22.100] ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba9d43sm5343384eec.10.2026.06.04.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped
 tasks
From: AnonymeMeow <anonymemeow@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
 AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
References: <20260603001516.26234-3-anonymemeow@gmail.com>
 <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner>
 <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
 <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
Date: Fri, 05 Jun 2026 04:29:47 +0800
Message-Id: <178060498710.12657.15047020114378440191.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=anonymemeow@gmail.com;
 h=from:subject:message-id; bh=E0eGepHGYQKUs/ko84r1foShV2m+ylziZzZEGSZpoDU=;
 b=owGbwMvMwCWmOm1nep3jlf+Mp9WSGLIUH9iEf1cQZlqQ57YmNXTzLqepLlVvit7kBV76EMy65
 //iaYc5O0pZGMS4GGTFFFneOApoP/q88U7B+/f8MHNYmUCGMHBxCsBESoUYGW46fn7/fVXcY4s6
 r8uHL89Xqj3GKfir9WKyiam4zsoITjWGfwbrlc/rMO0stuk/vomz1VopfKtlxa3um00RucFOh4+
 48gMA
X-Developer-Key: i=anonymemeow@gmail.com; a=openpgp;
 fpr=EC41102BE2F3B1DC70EFEF0F2596B9677E41D4FF

On 2026-06-03 13:25 +0200, Christian Brauner wrote:
> On Wed, Jun 03, 2026 at 12:58:09PM +0200, Amir Goldstein wrote:
> > On Wed, Jun 3, 2026 at 12:28 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrote:
> > > > On Wed, Jun 3, 2026 at 5:11 AM AnonymeMeow <anonymemeow@gmail.com> wrote:
> > > > >
> > > > > Sashiko said that pidfs_register_pid() can fail under memory pressure,
> > > > > since it allocates memory using GFP_KERNEL without a way to pass in
> > > > > __GFP_NOFAIL. This can cause fanotify_alloc_event() to silently drop
> > > > > the event even when the group has an unlimited queue length.
> > > > >
> > > > > Should we make pidfs registration best-effort instead and still return
> > > > > the allocated event if pidfs_register_pid() fails? But IMO this will
> > > > > make the API semantically ambiguous. If the kernel guarantees that the
> > > > > event pid is registered with pidfs when pidfd reporting is requested,
> > > > > then a later FAN_NOPIDFD or -ESRCH can only be caused by the task being
> > > > > invisible within the reader's pid namespace. But if we allow best-effort
> > > > > registration, the event may still carry a pinned struct pid, but pidfs
> > > > > registration may have failed due to memory pressure. If userspace reads
> > > > > the event after the task has been reaped, it still gets a FAN_NOPIDFD
> > > > > or -ESRCH due to failed pidfs registration caused by memory pressure,
> > > > > IMO this should be reported as a -ENOMEM instead of -ESRCH. But
> > > > > currently it seems we don't have a good way to register the pid with
> > > > > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferred
> > > > > approach to handle this situation?
> > > >
> > > > Thanks for noticing the oddity and explaining the options.
> > > >
> > > > We could fail the event in case on ENOMEM because the system
> > > > is likely is a bad shape anyway and other events are likely to fail
> > > > allocation themselves, so I am not objecting to your patch as is,
> > > >
> > > > but I am slightly leaning towards the semantically ambiguous API.
> > >
> > > As usual, I think a semantically ambiguous api should be avoided.
> > >
> > > > I don't think that we are going to change the man page to say that
> > > > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> > > > add a NOTE about increased likelihood of getting a pidfd since kernel XXX
> > > > and mention the known cases of pid namespace and ENOMEM.
> > >
> > > The pid namespace shouldn't matter.
> > 
> > DO you mean that the event reader inside a pidns always gets a pidfd but
> > it will not be able to query the pid of the process outside the pidns
> > or do you mean something else?
> 
> So they will always get a pidfd since fanotify is correctly using
> pidfd_prepare() directly. But when the reader tries to resolve the pidfd
> to say a pid or retrieve info via the pidfd info ioctl they would fail
> to do so (well, the pid will resolve to 0 which is the global indicator
> for "can't be resolved in your pidns").
> 

Before pidfd_prepare(), fanotify checks whether metadata.pid is
non-zero, i.e. whether the event pid is visible in the reader's pidns.
If it's not visible, fanotify will not create a valid pidfd and return a
FAN_NOPIDFD. This is the existing behavior, and my patches do not change
it.

