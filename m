Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D522156C;
	Sat,  7 Feb 2026 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770457514; cv=none; b=qlj8EMNlDL6PHJIOgnhi7swzT9dQTrnHJxMosz/qnZecwjYAnP0ZEceqyjhvXmjYEpWKmIiHM6/astMAuaoD0FFDm8g4QWeJTa6VbOPfGOiN6DirXe5EgJMcB9hlS0zGkgetuPDS4owG28aVNZoLeEyhmGFj5D0PwVAA/N6ktlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770457514; c=relaxed/simple;
	bh=Ik0Jvm5kvWOCUivx1AlDBuFmO5FHZMqdflfEhVA5p5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxNQmuMMiyGax/iSVBR1THwsQY5rfm7xkP7xbdGhLJ1VLeCd0ZlF61YS5Nko5qX7HRs1rT4Q/jxQ+YdqFuRwN1YJq4hP5ecDPzDOg62UWsJ/wzjop1avdgMcbqN2lp90gh0UkVWAyKsLM9JD+1f1yJG/dAw2LWCLgZsOMyN5DiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6179ir1L047340;
	Sat, 7 Feb 2026 18:44:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6179irg5047336
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Feb 2026 18:44:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <202dc17c-99dc-4dbd-afae-bb148e7cb025@I-love.SAKURA.ne.jp>
Date: Sat, 7 Feb 2026 18:44:52 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] hfs/hfsplus changes for 7.0-rc1
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        frank.li@vivo.com, jkoolstra@xs4all.nl, mehdi.benhadjkhelifa@gmail.com,
        shardul.b@mpiricsoftware.com, torvalds@linux-foundation.org
References: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
 <a1602ccf-73ce-46a3-b2f9-76cc7d2401e3@I-love.SAKURA.ne.jp>
 <66af2e9a17dab9f1ef79ad5812ec91aa9c0be005.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <66af2e9a17dab9f1ef79ad5812ec91aa9c0be005.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/02/07 17:55, John Paul Adrian Glaubitz wrote:
> Hi Tetsuo,
> 
> On Sat, 2026-02-07 at 10:18 +0900, Tetsuo Handa wrote:
>> On 2026/02/07 9:26, Viacheslav Dubeyko wrote:
>>> Hello Linus,
>>>
>>> This pull request contains several fixes of syzbot reported
>>> issues and HFS+ fixes of xfstests failures.
>>
>> Where is the flow for testing these patches in linux-next tree?
>> Are HFS/HFS+ patches directly going to linux tree without testing
>> in linux-next tree?
> 
> The HFS/HFS+ tree should be part of linux-next which is why it's got
> a branch named like this [1].
> 
> Adrian
> 
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git/log/?h=for-next
> 

Oops, the patch with old Reported-by: was applied. That's why I can't find
"hfsplus: pretend special inodes as regular files" as a fix commit for
https://syzkaller.appspot.com/bug?extid=f98189ed18c1f5f32e00 as of linux-next-20250205 .

Anyway, my patch was tested for one month in linux-next tree, and
it seems that no side effect is reported. Please proceed.

