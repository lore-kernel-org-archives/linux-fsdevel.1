Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CE3822BE;
	Wed, 15 Jul 2026 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126766; cv=none; b=QFjjS6a6mNGetotn1PbbcOa7geuOzkElKaeefeeBS7XPBk5/lyBt0IFAPFJsqnFdmSuV9L42UYqPJm8TJC4QBT9av1jn9aFq185UI6asjjhiP+CyfoNAocsP5ChtwKFg9DZVwl8AoZBxMNBUrssz6VwpT/3MsC1D7KO2477ZS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126766; c=relaxed/simple;
	bh=gXWsKSGu/hXrei0ltgYFcuQ9X4lyGegLPkUlXOTj1BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGyg7D6rQY+iLUerqWHEMXRU3gBhnhLjskX9XBDnkMT5aVI29lqVuC7FSXg2eI+w23rNtkkPA2MiF5Pni8GQlYV9h/OZhtF+ctgjwWGaKu2U4G6YJ5dmD+9NmJ4MW+qOtJdPPtyShnqgQrxB60idqTvY2AsP/NdftH6bVniOM6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 66FEjihv040301;
	Wed, 15 Jul 2026 23:45:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 66FEjiiw040297
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 15 Jul 2026 23:45:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4ea4703c-7385-4f75-aee2-f21a6c8cce82@I-love.SAKURA.ne.jp>
Date: Wed, 15 Jul 2026 23:45:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [loop] d908729e74:
 stress-ng.umount.ops_per_sec 100.0% regression
To: Christoph Hellwig <hch@infradead.org>,
        kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-next@vger.kernel.org, axboe@kernel.dk
References: <202607151655.9d74999d-lkp@intel.com>
 <aleZammRRSVN4dl0@infradead.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aleZammRRSVN4dl0@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp

On 2026/07/15 23:30, Christoph Hellwig wrote:
> It's also a patch that has never been added to the maintainer
> tree for goot reson. Tetsuo keeps doing this, so can we please
> stop including their trees in linux-next as there seems to be
> no other way to stop this?

Then, can we please keep discussion on
https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 alive?
I am asking Al Viro to reproduce xfs/259 problem, but it seems that
Al is too busy to respond. I can drop this patch if somebody is
interested in fixing this bug which became visible in 7.1. Current
state is a result of insufficient interests/resources for debugging.

