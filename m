Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E44BB5C7;
	Fri, 16 Oct 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158622; cv=none; b=P7OpyCC/lT/mISu1ZVPUW/tes1CAis4IZENcLVJZpWrgk9TYW9mk6iRjVhggFw3DkXvNWjlRftSoKGCzTo5IxVgk3O8Pei19vdlvypF0+aSxZteS9rBQEWF2crvIxtZ+slkPdRv5Yyo7BIdsGn6UBtttSJe2lWudoGC2/MPt08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158622; c=relaxed/simple;
	bh=9zwwUGWCjaNsK1GdJ4D3fl8irBgBHgn9e4EUA10snOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gSCD+B+owX6s2OPQPvnNGwgWX8E7cZpVDj9cRQpELq3HTL3MFGNO2DRT8XZv+QI3aJin2BU3Zm/Yll21KFMshxe7d3BxxfQPamg4algHmxd3MvbUR/WgOhr5DHnxeJ7UTgB8jBjHHV0qUx/+MUVatiAriRzamI50BTDSblRtHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=ueE7oYO+; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=1mxH9raS; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="ueE7oYO+";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="1mxH9raS"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 7FBED26F7667;
	Fri, 16 Oct 2026 22:50:16 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792158616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwDIJ0+Alc1iUuZG14DuE+UHUc9nflA7dy8tOISQqLg=;
	b=ueE7oYO+W1uhIauf5LG/YdsKGeL6DfYDn7NLakNr0wDYtYtbtwA2P6ualqVUji2ta0bIZb
	a4PhoB240uRdV9iuGqvV8VN63r990EdRUCjtYsTlfDZAWGS4PAaHSFcQ4tr1XfCVEEl6Sm
	oECteZDkBOLiMaeeSc/6vsuUXVFgwSnNlReGPW4458X4z60Js+jzB5ZLy547lxmQmMLXM/
	myrc8EAI3Ugc8hSqQmRQUkz0EG9kiqW+HaIWQby9KdfjDJkTHNz2/1EHrT44X5dUchY/gm
	wfcpnOI9OGfVJX8EzyDNLphtGLroizUnPUPGU7pxRn4WOjHaPG7Y6i2+/fbIQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792158616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwDIJ0+Alc1iUuZG14DuE+UHUc9nflA7dy8tOISQqLg=;
	b=1mxH9raSOZey7otCY1kfGEJqdYDupqrynew/e/xt1BSy2vDkjBIVnBqss/xOV8VJ9nA53t
	/EOwr4xs7xdJUCAw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id BAF69E00144;
	Fri, 16 Oct 2026 22:50:15 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id B094B22000BD; Fri, 16 Oct 2026 22:50:15 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] fat: make rename recovery safe after metadata write
 errors
In-Reply-To: <55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
	<20260929090029.742579-1-krystianmkaniewski@gmail.com>
	<87ld8j4161.fsf@mail.parknet.co.jp>
	<1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
	<87bj90m6dq.fsf@mail.parknet.co.jp>
	<20261014082315.190262-1-krystianmkaniewski@gmail.com>
	<87qzhqvloo.fsf@mail.parknet.co.jp>
	<55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
Date: Fri, 16 Oct 2026 22:50:15 +0900
Message-ID: <87cxt921rc.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> On 10/15/26 20:54, OGAWA Hirofumi wrote:
>
>>> +	} else if (!rollback_err) {
>>> +		/* Read the entry block again if a failed write invalidated it. */
>>> +		rollback_err = bh_read(sinfo.bh, 0);
>> 
>> Why do this read the bh from on disk?
>> 
>
> The bh_read(sinfo.bh, 0) is needed because a failed inode-position write clears BH_Uptodate. fat_remove_entries() modifies and dirties that retained buffer directly, which otherwise triggers the warning. Reading it first refreshes the whole block. If the read fails, the buffer is left untouched.
>
> The same reasoning applies to both the VFAT and MS-DOS paths.

If sinfo.bh is required to read because of failure of I/O error, I guess
the bh will fail to write again. I think we should give up to rollback
in that case.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
