Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E42E03E4;
	Wed,  8 Jul 2026 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552194; cv=none; b=b49T0xvU3XUbKQZSQ+9BCh5/q70CTKDB8QwFndC3WUFX+k+zKCJ784e5E8A2jJcOkjzf8Yae4Q50TmWZWOutpVEvIpkjbk4Zf7awI9anRldI/ZwCk3KMH0IFJAr3gjUTlc95Xb9MrQCLlf787YtgcUrQ1LDQXzk9RNgzgokVK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552194; c=relaxed/simple;
	bh=z22MfH0I1AGJ7gHTQkT26jdrF+ZA5gRox6HtTLzwAVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cxM6zgmR42oVNPTeFgV9YNY/aTe6Hke+x0aOO6gMWtNCMaDG8VzXiKIvRcVhdcGnscRGVYwYMV8HlbAfN/xETirELP6dZsoOmdqXM2tFgC+6K0qG24s7R52RhWj5BqBg0i+z3HI/HH2NZ2j0MIF8yJajqeq13PntBWuyUV7l20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 668N9IC0010112;
	Thu, 9 Jul 2026 08:09:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 668N9HQV010109
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 9 Jul 2026 08:09:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cc2da0cd-8f80-4c95-9bf1-9bf39a38e2f4@I-love.SAKURA.ne.jp>
Date: Thu, 9 Jul 2026 08:09:17 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hfs: validate catalog CNIDs before instantiating
 inodes
To: Viacheslav Dubeyko <slava@dubeyko.com>,
        David Maximiliano Hermitte <davemadmaxxx@gmail.com>,
        Jori Koolstra <jkoolstra@xs4all.nl>
Cc: George Anthony Vernon <contact@gvernon.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <20260707232850.510374-1-davemadmaxxx@gmail.com>
 <20260708215636.73815-1-davemadmaxxx@gmail.com>
 <169699d11b667008b0b15f96f4ee5164fb31bb7f.camel@dubeyko.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <169699d11b667008b0b15f96f4ee5164fb31bb7f.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp

On 2026/07/09 7:17, Viacheslav Dubeyko wrote:
> Looks good. Thanks a lot for the fix.

Not a new bug introduced by this patch, but sashiko thinks that
there are things to check.

https://sashiko.dev/#/patchset/20260708215636.73815-1-davemadmaxxx%40gmail.com

