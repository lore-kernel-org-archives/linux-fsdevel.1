Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8341937F8DA;
	Wed, 26 Aug 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787728891; cv=none; b=jfxC0njuygI32s6B85z4FBkoOTNj/SIxLo5yMLs5/RlNmLCcEO6cXGJ5n8tbdJiJxaW0+FRLC8/qJYXRPPNWrTN5jAw/TJV4BT4GsvDzP8IlNZwkLjijaE3eS9SfecP+3Cq8fSBgK6BeS/e9yk82N/EAeJDETU9XuwvGTDdhakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787728891; c=relaxed/simple;
	bh=7f8AliVFuzVWZrcc3oSQ6Wa30G5vBDD85rUnKfrIdTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vEPvBZoRsfFc53UZ7Hs6NOU9IXlj86GQ7fTZGVJnuYVYtbxKF4EASO5BARCONVs3aMPx+FYO9qX2iZjTroe2QHjds783PX+L+tRZMeQsHnFDYSJYuBTClEd4kzevlxy14CZBrfaS4LRNfs5z6rN4x2Yx0V+K8lQ4VZ3ss7yR8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=5He4etHk; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=SRhBPmtj; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="5He4etHk";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="SRhBPmtj"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id A40DF2096798;
	Wed, 26 Aug 2026 16:21:24 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1787728884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLQU4f5ng+QHPRbC9N2jlxMSgXathc2ApvwvxDPJLn8=;
	b=5He4etHkMT5L2EzmO8n4CbYi+TDPHYm3DCg9Brbfuq5lzhLkrj46SjFbR2IK0X96uZEYCl
	kqpSYmpgAb7ytBqSLgb0LpZPbQBNIsJiMRN++kjypANr/upql0VCKxtxcoLMnjjhO7ZgJz
	KoI5htWaXWZ8m5S/4NTwLMIaa+l8SO4LsRLTniknbpu2/7jr7kODimQBZIEfqmbUbgEv/I
	zQHesNwY+9b3mMSk7G0tHNmAq5f9lnYZSa/EhjKkXxsuKv6gM2sq1O5/20hxC1/HnKHTNJ
	wtsvXV+l0BkD4O23pi/g48p+FLJImsyaeesjDMua/tUvAG7NUdqFw8+4mIfxsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1787728884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLQU4f5ng+QHPRbC9N2jlxMSgXathc2ApvwvxDPJLn8=;
	b=SRhBPmtjuPSrkuRl8E5V+pP+OnYif061DvH/adUP4lH5zKiQHhZJrUWYvbWJ4N2AURbH8o
	rG5LYy6cIQdTWCDA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 2D28CE0006B;
	Wed, 26 Aug 2026 16:21:24 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 24ACF22000F0; Wed, 26 Aug 2026 16:21:24 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: David Timber <dxdt@dev.snart.me>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fat: add noflush mount option
In-Reply-To: <b451b5af-adf4-4b2b-9056-641ae26158c9@dev.snart.me>
References: <20260822173732.10230-1-dxdt@dev.snart.me>
	<871pbn6edz.fsf@mail.parknet.co.jp>
	<787aea79-beb0-4f29-bb67-ee57f6c654c4@dev.snart.me>
	<87ecfmrfb9.fsf@mail.parknet.co.jp>
	<b451b5af-adf4-4b2b-9056-641ae26158c9@dev.snart.me>
Date: Wed, 26 Aug 2026 16:21:24 +0900
Message-ID: <875x0xpcsr.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Timber <dxdt@dev.snart.me> writes:

> On 8/25/26 13:31, OGAWA Hirofumi wrote:
>> Well, with a your patch, just remounting without "flush" option doesn't
>> remove flush?
> fat_parse_param() doesn't behave like other fs. The current
> implementation only accepts rw and ro for reconfig. So the option cannot
> be flipped up and down at will.

I meant with your patch. With your patch, it updates flush to current
option set, right? And default flush=false, I may missing something
though.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
