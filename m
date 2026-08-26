Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB33112B2;
	Wed, 26 Aug 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734663; cv=none; b=vBhDZrMj2hni2z5EvMIRzyC2MGi/m+IlzzcWfvp91TZclnDHcNBhgGbRk3vqdE18KSdlerYK7vr4svv/F5rJqhhmfppcMqoHdicSMsiO1RNWRNrV82BndJ9cCbMdZ/qFuNVcJmJ5mxlKlHo0BGXRQSXFymNX5FQp7p0Y4PeA0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734663; c=relaxed/simple;
	bh=eklj3OU5d2uhpiIxZ28sdI8qGsKqPURwpIGmEJeB7ow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZTmQ2+o3IsTs1ihYhUDbx3ST/doOk3ao2hYyO8/hchZ7/xNZ6Hk2CrDmzMSMNl/L1rZuh3o0Pj1ykRreAOi4K9h22C1RJ/z978dPDOXVteH7G4uG1NftBGAhZ+Gy45RgFFHlc40KFTWWkmYTNZ2SmJ06TbOmhwm2A7dfc4A6YIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Ems3ji7z; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=uaWoYoYh; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Ems3ji7z";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="uaWoYoYh"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 81BB926F768E;
	Wed, 26 Aug 2026 17:57:37 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1787734657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nougTuZdQgF3hWVIl8JT8yF352s+Ws8kEAbSCyYMyvc=;
	b=Ems3ji7zAWZEa1Yfu0I6JkzrR1Qf/scZCHUmgyM8Uj1oG+JvO0A6/jlX5UDk0o8QrBN5Jo
	YynrqKesMTxJUjTjG8WMlWTA/B7wcSWCwqgbkcPX4E2AppixXMtZg4RFKDdEC6wfpzbimK
	8X1mnve4hORN38ulWI9+oTYJoYDLvbapDK9GGDJUBxH8fqYAZvlXpKvOigwPxUGFYMBCSY
	pP1l705W3FZZ81zkw/Lk/eRKTfgt2lawrvtyoamnbDhgrxat7m5TdOklX0armcjOdFz/r+
	4o/YFBsBdGmx+JHd2ZNDa4RAvGyRsnYx37cwgKyZ5UirTh7F5UyzBKYX5D0uXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1787734657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nougTuZdQgF3hWVIl8JT8yF352s+Ws8kEAbSCyYMyvc=;
	b=uaWoYoYh88zHKD8NNIQAjOKEdA5+Zcd82ZYMQha6xneDKFKlSirBewA4lwV91ImLQ3PgXp
	r72Bgj+GD7WFn0Bg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 0BABAE0006B;
	Wed, 26 Aug 2026 17:57:37 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 01BDC22000F0; Wed, 26 Aug 2026 17:57:36 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: David Timber <dxdt@dev.snart.me>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fat: add noflush mount option
In-Reply-To: <75c9377d-33ee-472c-911f-33a3e1f661d6@dev.snart.me>
References: <20260822173732.10230-1-dxdt@dev.snart.me>
	<871pbn6edz.fsf@mail.parknet.co.jp>
	<787aea79-beb0-4f29-bb67-ee57f6c654c4@dev.snart.me>
	<87ecfmrfb9.fsf@mail.parknet.co.jp>
	<b451b5af-adf4-4b2b-9056-641ae26158c9@dev.snart.me>
	<875x0xpcsr.fsf@mail.parknet.co.jp>
	<75c9377d-33ee-472c-911f-33a3e1f661d6@dev.snart.me>
Date: Wed, 26 Aug 2026 17:57:36 +0900
Message-ID: <87zey9ntrz.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Timber <dxdt@dev.snart.me> writes:

> On 8/26/26 16:21, OGAWA Hirofumi wrote:
>> David Timber <dxdt@dev.snart.me> writes:
>>
>>> On 8/25/26 13:31, OGAWA Hirofumi wrote:
>>>> Well, with a your patch, just remounting without "flush" option doesn't
>>>> remove flush?
>>> fat_parse_param() doesn't behave like other fs. The current
>>> implementation only accepts rw and ro for reconfig. So the option cannot
>>> be flipped up and down at will.
>> I meant with your patch. With your patch, it updates flush to current
>> option set, right? And default flush=false, I may missing something
>> though.
> Of course. It shouldn't change the default behaviour. When mounting, if
> "flush" is in the mount options, it must be honored UNLESS "noflush" is
> also specified later in the sequences. If neither "flush" or "noflush"
> is specified, then it's not set at all. Specifying "noflush" only should
> be no-op.
>
> If the patch doesn't behave like that, that'd be my mistake and should
> be fixed.
>
> When doing "mount -o remount,..." the patch changes the existing
> behaviour so that "flush" and "noflush" are now honored. Regardless of
> the previous sbi config, for "-o remount,flush" -> it always sets flush.
> For "-o remount,noflush" -> always clear flush.
>
> Hope that cleared things up.

OK. It is compatible way with current FAT behavior, however, it is not
compatible with other FS behavior. The former behavior may be safer for
current script.  However, on the other hand, the latter would introduce
other type of issue.

So, which is better is not easy to decide more or less.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
