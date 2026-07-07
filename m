Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BD2C0299;
	Tue,  7 Jul 2026 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461715; cv=none; b=K5OzjnK49coa6XlEE/01rJnF5TWH+LXgasqGkB/vksAtXIyW9LkKUKxkouIMmO8faB6r0MO94fwZshwYZTvuSaC38tEFIa1Cf9ZVoaHqKWhBEXau28Xv3ft3oWdArl6n9q80LNysrfCVZzpWscLNPn/8nXdXeb3O9CNrQhTmbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461715; c=relaxed/simple;
	bh=gsH5XxlWw3XJRQjp5Hig45f/sWxDmYPFXbcoMuS/yIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/3WlzSQpFNAFV8nUUbMLnUvcMbwhVlxQ4UsZ2v6qTuwqNoI0jOLSREzVM6f+xwrre0BodLipZZJ67/+PnvGFuVwcOzl7zY7VhYhxUfNst1O/w/7Pjn62JPqcwMXUcEo2b0xEHSuARMS5Y9myBAJJ6UT+cqCI3yzyemNSArw7JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 667M1Mec008512;
	Wed, 8 Jul 2026 07:01:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 667M1MCj008508
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 8 Jul 2026 07:01:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a0c18c14-6dd7-4848-9443-51935c9c23e5@I-love.SAKURA.ne.jp>
Date: Wed, 8 Jul 2026 07:01:22 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND] hfs: validate catalog CNIDs before
 instantiating inodes
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
        George Anthony Vernon <contact@gvernon.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
References: <20260707213834.431563-1-davemadmaxxx@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260707213834.431563-1-davemadmaxxx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

On 2026/07/08 6:38, David Maximiliano Hermitte wrote:
> I will prepare the next revision after your guidance on that point.

Please check sashiko's comment at
https://sashiko.dev/#/patchset/20260706095943.258065-1-davemadmaxxx%40gmail.com .

