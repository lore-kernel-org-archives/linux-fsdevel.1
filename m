Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33C02E8DFC;
	Tue, 10 Feb 2026 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721957; cv=none; b=pJ6q9+LuWWedTO0DiV84QGdlrRcLjOIDZzSMqyGELA7n5Ce+LVxDVZOGiJvJJhEGDFY47MAJLUdeMgfcFBy2fEQeq1DesHgJDoknsueBzJL15FCBYspPy2K5zphjeyNZzbcsfTCklXvdDI0Usd6zQBV4SpGU0ooX+6P8wiOpTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721957; c=relaxed/simple;
	bh=cgkEJQvpoJ0K3WvdcV1S0usHKgOx1aWDifndN4ScNqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tj5EJKFvJgLTRQN01rzVk9cvB36fb2diohFekqjJhdscZfEqL3d+uWFNs3uVFNJF9mI7g8KCsldZBPRT3uBcxYaJi1B7OxSM2Ne8KN7g1prL32yjtjcwdYvT8VK5PlNyz4Y3t9YQhELANuL9tFSZCKDZ8TpYREUKwguCBP84vK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 61ABCC4O045753;
	Tue, 10 Feb 2026 20:12:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 61ABCCwR045750
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 10 Feb 2026 20:12:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6a99ecc3-ba7c-4687-9252-b4ea91ce9dfa@I-love.SAKURA.ne.jp>
Date: Tue, 10 Feb 2026 20:12:11 +0900
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
        mehdi.benhadjkhelifa@gmail.com, shardul.b@mpiricsoftware.com
References: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <9ee4d3b9c7e2131f274c5d1eb2bfcd009a92c765.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/02/07 9:26, Viacheslav Dubeyko wrote:
> Jori Koolstra has fixed the syzbot reported issue of triggering
> BUG_ON() in the case of corrupted superblock. This patch replaces
> the BUG_ON() in multiple places with proper error handling and
> resolves the syzbot reported bug.

I think that commit b226804532a8 ("hfs: Replace BUG_ON with error handling for CNID count checks") is incomplete.

Since atomic64_t is signed 64bits and U32_MAX is unsigned 32bits, the comparison
"if (atomic64_read(&sbi->next_id) > U32_MAX)" becomes false when sbi->next_id >= ((-1ULL) / 2) + 1.
I guess that a corrupted filesystem can have e.g. sbi->next_id == -1, and
"if (atomic64_read(&sbi->next_id) >> 32)" would check that the upper 32bits are all 0.



Also, I confirmed that this pull request did not include a fix for
https://syzkaller.appspot.com/bug?id=ee595bf9e099fff0610828e37bbbcdb7a2933f58 .
I'm waiting for next version of patch for this problem.

