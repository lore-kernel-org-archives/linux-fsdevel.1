Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC14DE719;
	Fri, 16 Oct 2026 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164237; cv=none; b=apqm61PdMeN3EvxAeY0sc77ovHDNw3caUxgpmSf4Fd472CFI26T6EurwUtwNZbAKDNziGh2vQz7bH6AW0ixojC7p/zq2tzsAWA32rYc8uvvOG/s131ur32/nX7MVe3hBgcsy3ZImunkTkQ7EnV4xYgBwE6gCdjKakSg4AsifWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164237; c=relaxed/simple;
	bh=YIXYhXMxCZMEKbrJiCIAwvz47mLXuIeDgCfiZX3TUbM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glpj0sZb3Bn1p0x/3iZ5HneCvrUTOYJGBkSLGF1YbRIDTc/aFAVJPcDh2o+NUFBXjhMnTKKJ1BWexskV8kA9FB/znInnaLY2d/nR32NMxICXq+fIJwg1msl+SIJeGLUF/7v2ov5fxft50smWHPXbvPBtoK4s4+Xl1vBF5WRRsm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=VCGl+o9Z; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=pgDrERoJ; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="VCGl+o9Z";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="pgDrERoJ"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 30D2826F768C;
	Sat, 17 Oct 2026 00:23:48 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792164228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAQih599BqBXVUR3ixTWbJQr3n+B1xUsdiaITVImHv0=;
	b=VCGl+o9ZCldAYY6Vp1KPtKf8S31qmCZNhe8VPNblQMVI9sk7a4l9enBABO9K7SAamQBBty
	Cjp9hZuH/Rdc4ads7bMrMR79WIl3v6V4lTR5RWffAVX78vE+eAhBNDWQ40acJsdrT66ct8
	jQN+qWsDRIYqQDpZHqx9WHk0dyvgVqS0SkrEZK8PYs0RHJHz9gnnFcT2cdTSoWvSSIgjj1
	hBche1/koysmx/+exBALmEu9CBRpTrzoosGy5il2znCIWXcd/igRzHlDukh/jREQi3+Ij3
	1tSO16RiqFt3bX+OVNih0GAR+KW739iLgLZRsmiyuJeDPyFcOZa/PwJwBVRniQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792164228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAQih599BqBXVUR3ixTWbJQr3n+B1xUsdiaITVImHv0=;
	b=pgDrERoJVi3HqIpwSEFRVO4Vr2ndaYiaA7KoEWza9/xj/pcb1qEUQk2suDDj0TUVtBHBwC
	ZIc4g1RKuckD0dAg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id AED11E00144;
	Sat, 17 Oct 2026 00:23:47 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A802322000BD; Sat, 17 Oct 2026 00:23:47 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] fat: make rename recovery safe after metadata write
 errors
In-Reply-To: <f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
	<20260929090029.742579-1-krystianmkaniewski@gmail.com>
	<87ld8j4161.fsf@mail.parknet.co.jp>
	<1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
	<87bj90m6dq.fsf@mail.parknet.co.jp>
	<20261014082315.190262-1-krystianmkaniewski@gmail.com>
	<87qzhqvloo.fsf@mail.parknet.co.jp>
	<55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
	<87cxt921rc.fsf@mail.parknet.co.jp>
	<f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com>
Date: Sat, 17 Oct 2026 00:23:47 +0900
Message-ID: <875wz11xfg.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> On 10/16/26 15:50, OGAWA Hirofumi wrote:
>> Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:
>> 
>>> On 10/15/26 20:54, OGAWA Hirofumi wrote:
>>>
>>>>> +	} else if (!rollback_err) {
>>>>> +		/* Read the entry block again if a failed write invalidated it. */
>>>>> +		rollback_err = bh_read(sinfo.bh, 0);
>>>>
>>>> Why do this read the bh from on disk?
>>>>
>>>
>>> The bh_read(sinfo.bh, 0) is needed because a failed inode-position write clears BH_Uptodate. fat_remove_entries() modifies and dirties that retained buffer directly, which otherwise triggers the warning. Reading it first refreshes the whole block. If the read fails, the buffer is left untouched.
>>>
>>> The same reasoning applies to both the VFAT and MS-DOS paths.
>> 
>> If sinfo.bh is required to read because of failure of I/O error, I guess
>> the bh will fail to write again. I think we should give up to rollback
>> in that case.
>> 
>> Thanks.
>
> Thanks. I was trying to handle transient errors here. The old entry still exists at this point, so if the read and removal succeed, the rename can be fully rolled back.
>
> In my tests with a single injected write error, giving up left the new entry pointing at the root directory, and fsck.fat wanted to remove it. Retrying the cleanup left the filesystem clean. If either the read or the cleanup write fails, we stop and report corruption anyway.
>
> Do you still think we should give up here? If you prefer not to retry the new-entry block after its failed write, should we also avoid rereading and rewriting dotdot_bh after a failed .. update?

Basically that path is not the failure of sinfo.bh, true? If so, we will
not need to re-read sinfo.bh here, just removing the added entries would
be ok. 

If we have to read sinfo.bh, the sinfo.bh may be failed the write and
cleared the uptodate. If so, I wonder why succeed by retry?

The above is my understand.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
