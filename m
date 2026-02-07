Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C81EB5C2;
	Sat,  7 Feb 2026 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427131; cv=none; b=E7+ixNn1DljubGpLOEYtm3G4VYVEAHs4TBC11a26YOnAuSLvefy5fwvwozr7KOcfet5u2v1nWQMZFfAbMY7+cu6YGwvOiTjEAT/C6JQHklUqNuSCwbE3jDnbMb++cQ7R1dtDn4Z4GeqMyxB961WlME9QW2/YsuavabyJH9O9EbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427131; c=relaxed/simple;
	bh=X/hE6rAiu07EUPe/k5K11Xb6/oihkXPY4hqPA2Kou6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hf8ba/UihH577xfLhDOXzVHsdFQT57d1c3cCQ4vJBT5JzZSQxGf7P3T/RWebxvZwQZ7M2BKgdyJuMLRrKhkx9eTg94q32SnrVfCg3VjIRKufU2L5wECLYoIefUZhloqvE81uzOOPZJDFVt68SMlSc8ae0gyOkRIqL/j21hJz22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6171IRmW070668;
	Sat, 7 Feb 2026 10:18:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6171IRRD070665
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Feb 2026 10:18:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a1602ccf-73ce-46a3-b2f9-76cc7d2401e3@I-love.SAKURA.ne.jp>
Date: Sat, 7 Feb 2026 10:18:27 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] hfs/hfsplus changes for 7.0-rc1
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com, jkoolstra@xs4all.nl,
        mehdi.benhadjkhelifa@gmail.com, shardul.b@mpiricsoftware.com,
        torvalds@linux-foundation.org
References: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/02/07 9:26, Viacheslav Dubeyko wrote:
> Hello Linus,
> 
> This pull request contains several fixes of syzbot reported
> issues and HFS+ fixes of xfstests failures.

Where is the flow for testing these patches in linux-next tree?
Are HFS/HFS+ patches directly going to linux tree without testing
in linux-next tree?

