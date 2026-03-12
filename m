Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38D3C13F5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321854; cv=none; b=ftqxIKFYdBms9vuGDrUxv0L8olvq7ETjSGu9DUEsQpi14+cZig1pp8RKQnl1imvFJVPSGDkbgic9OlBW3fk2MfSAVz/WjjcxJboIEOD8lafLEWxIiT9PaMwPHqJdW/9FwfzmuHbKR5knfq7Q/R17vmNmVvjdt95R7/YK8BOvB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321854; c=relaxed/simple;
	bh=O7+FKtNqOQ9SDnjWLr5KYDVfPnAPeasA1HcFbLGq2AM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jGHIVstBl63wOP+XH9P5LSqm/JIdTa2/H7NB+9uOsp27HEgxINPJB0e5n9ViyCBLH8nVyOBxFoQOpj+MM0tpMiuct/gJYYzyyK/T1YtsPyrt6piOUOZXFLvG7jS0/lmN1AQ4NC4HtiECtxcWfIhpogxjJNdA+o9PG3FlfkC7+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62CDO1hc068832;
	Thu, 12 Mar 2026 22:24:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62CDO1C3068825
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 12 Mar 2026 22:24:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4c2f1aff-b892-496e-9856-157b507ce5d6@I-love.SAKURA.ne.jp>
Date: Thu, 12 Mar 2026 22:24:00 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hpfs: obsolete check=none mount option
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <fd8dabf8-f0a5-418a-9b3d-da981101ca86@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <fd8dabf8-f0a5-418a-9b3d-da981101ca86@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp

Linus, which approach is acceptable for you?

(1) https://lkml.kernel.org/r/51bdd056-61dd-4b57-8780-324b2f8bc99f@I-love.SAKURA.ne.jp

(2) https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/fs/hpfs/super.c?h=for-6.20/hpfs-changes&id=a4664a2bc61c2abbc772df9139da9dbd2b26dc7f

(3) https://lkml.kernel.org/r/fd8dabf8-f0a5-418a-9b3d-da981101ca86@I-love.SAKURA.ne.jp

