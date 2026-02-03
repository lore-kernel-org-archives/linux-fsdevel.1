Received: from a10-70.smtp-out.amazonses.com (a10-70.smtp-out.amazonses.com [54.240.10.70])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261FB31AF25
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.10.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138821; cv=none; b=sZUjAcHk6wpJ0HnTNcvI/XQniOOLcSag4X8yH8AcYF3BHUtBcZ/fRW1BXGsLki3Pcz653k0tNv8p9/TifXaWm1b/DP2Q1h/sWsx3JDaQTR4NQSCFz/DeEH0NsGTSnIKeR9b1QjjkQisnAK8tSM8XiSE5e2x7yJ3lmc0tgRum0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138821; c=relaxed/simple;
	bh=Fs1Pnax7C6WGnOU6Gwi74/7UWOiZlFIKwN9irIfAa0Q=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=Nwlln9E49X4I/4+ZHcyrC+/DWIZ44AwaphbL4+pUqN5payH24E5bz2rhPXvXXHx06IAERJnMrtBvfGIQpLUtbjUPdCUBcT8Tuzxl+m2jWFpQARW/DMxjAR+rwJql9JTcrBwKIxOakCvpCG/7ifoP7/ZvMbfh9k7OJoWAEk8svh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=YQEdKaoq; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=S659JPgG; arc=none smtp.client-ip=54.240.10.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="YQEdKaoq";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="S659JPgG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1770138817;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Reply-To:Message-Id;
	bh=Fs1Pnax7C6WGnOU6Gwi74/7UWOiZlFIKwN9irIfAa0Q=;
	b=YQEdKaoqYbd3ALalswl7q9JY7w89mBpj4a7s0P2D9FxfGHrCH3JM7jBFocbQ9cq8
	nW0czK5CZwDbPBT7+zWWgv/P7pB8Yfa2h4+0WAyPrSisrZt8pfVeP3X2MSGrVZqJCkj
	icStg+CfzngJeZTeLjgvOTNOesMTYKEMK/6RUa24=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1770138817;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Reply-To:Message-Id:Feedback-ID;
	bh=Fs1Pnax7C6WGnOU6Gwi74/7UWOiZlFIKwN9irIfAa0Q=;
	b=S659JPgGCsAYj9YjGT+7n/IDy4ajE4zTYFqujBp2YqO5Vnv4gDv19P3XMqszHOrt
	yP/xkLp02xJQYZRNiFf+lYhptUakbaHyHhpYFeOFCH8snEggHytQGEELCF6L2LNMphd
	4FUDNLs3L+ucM2p6d5+HOL+OfJqwRrFc/ioRPvsE=
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>
Cc: 
	=?UTF-8?Q?f-pc=40lists=2Elinux-foundation=2Eorg?= <f-pc@lists.linux-foundation.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Eke?= =?UTF-8?Q?rnel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Darrick_J_=2E?= =?UTF-8?Q?_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?John_Groves?= <John@groves.net>, 
	=?UTF-8?Q?Bernd_Schubert?= <bernd@bsbernd.com>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Luis_Henriques?= <luis@igalia.com>, 
	=?UTF-8?Q?Horst_Birthelmer?= <horst@birthelmer.de>
Date: Tue, 3 Feb 2026 17:13:36 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: 
 <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
References: 
 <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com> 
 <aYIsRc03fGhQ7vbS@groves.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHclTBulzBvpdDlRkWaruEdNxtF6g==
Thread-Topic: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Reply-To: john@groves.net
X-Wm-Sent-Timestamp: 1770138815
Message-ID: <0100019c247ed1a1-966e181f-c23b-47ba-bb45-bbc80bcf1c56-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.02.03-54.240.10.70

On 26/02/02 02:51PM, Miklos Szeredi wrote:
> I propose a session where various topics of interest could be
> discussed including but not limited to the below list
> 
> New features being proposed at various stages of readiness:
> 
>  - fuse4fs: exporting the iomap interface to userspace
> 
>  - famfs: export distributed memory

I plan to attend, and have been on the fence about whether a proper famfs
session is needed. I'm open to ideas on that, but would certainly
participate in this sort of overview session too.

JG

> 
>  - zero copy for fuse-io-uring
> 
>  - large folios
> 
>  - file handles on the userspace API
> 
>  - compound requests
> 
>  - BPF scripts
> 
> How do these fit into the existing codebase?
> 
> Cleaner separation of layers:
> 
>  - transport layer: /dev/fuse, io-uring, viriofs
> 
>  - filesystem layer: local fs, distributed fs
> 
> Introduce new version of cleaned up API?
> 
>  - remove async INIT
> 
>  - no fixed ROOT_ID
> 
>  - consolidate caching rules
> 
>  - who's responsible for updating which metadata?
> 
>  - remove legacy and problematic flags
> 
>  - get rid of splice on /dev/fuse for new API version?
> 
> Unresolved issues:
> 
>  - locked / writeback folios vs. reclaim / page migration
> 
>  - strictlimiting vs. large folios
