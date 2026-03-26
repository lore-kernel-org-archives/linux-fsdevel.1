Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB4A3F7AAB
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526333; cv=none; b=uPoxBlyAWRi662+eR06fpk1x3H200GWUIEFKw4p22KcJv7PtukyWWJQSBiWAsShhG5ou7w6svoHcCHLNyZyP45S1S8pShcfi0VrY0ew6dtDBOyJLDG0IF+Zyh+65JaLyllN9NKks2xboYv3VL9ifbdbXjMLZ5qr/OCx1Mh3iTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526333; c=relaxed/simple;
	bh=VThBL5pofIFJVOYZ6TktplDE3dzVmoq9br6yJg/XZ+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQID4fxFJuzz54W8rUn4dXp8HK8CpTWK8ZySztsWWF6UWLeUd4csYcU2nWadi1wo7eSz05gDb2AiB357MV/BeCKTmWfD7qU8MZySZOITTAsJUQiFnXdqfCdN5hYZQODYZNp/sZkkFrM19ZiR3diAWRRvUKcW3agmYvgiLN33L4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XUUB0rRc; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XUUB0rRc"
Received: from trampoline.thunk.org (pool-173-48-121-153.bstnma.fios.verizon.net [173.48.121.153])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 62QBvwdV020426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 07:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1774526283; bh=jlsf7X3CkLMyFg6+Hqc1+hj/cVF26q8sA2wu5PmSC80=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=XUUB0rRcxjapnUlfevjq6dRF2UrODiMU9xYf0ovEIoC2WSBRfYAvkG2yCONfUtm6P
	 oHttqyykSqyn+eN66gi8y0modBLs1mbQriojXNgWV0p4qyUW4AGFBSFHvq+/Zd6oWJ
	 JF5q8WxZtGYI0wvXxPPQiOtLZ6nnqg2VZAnFWwmJrY4uIYjNVMnShJ3jMVj3OHXSsu
	 OyeDcehPTkrzGpsmE6ibMf0Skj2rnbzN+s2fy4jCtiYlnj4Gcx7Yyi7orgfDpfYHHm
	 YvCxLhqigSdIcDRKtqhNtmANLsY9gzmtdVHMsdAPGSX5ZxjaxbNh4LSpwJpmtD15aI
	 pSEVbXRsO025A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 029172E00DD; Thu, 26 Mar 2026 07:57:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
        yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com
Subject: Re: [PATCH v2] ext4: do not check fast symlink during orphan recovery
Date: Thu, 26 Mar 2026 07:57:49 -0400
Message-ID: <177452625023.1205486.3085101060488489224.b4-ty@b4>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131091156.1733648-1-yi.zhang@huaweicloud.com>
References: <20260131091156.1733648-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 31 Jan 2026 17:11:56 +0800, Zhang Yi wrote:
> Commit '5f920d5d6083 ("ext4: verify fast symlink length")' causes the
> generic/475 test to fail during orphan cleanup of zero-length symlinks.
> 
>   generic/475  84s ... _check_generic_filesystem: filesystem on /dev/vde is inconsistent
> 
> The fsck reports are provided below:
> 
> [...]

Applied, thanks!

[1/1] ext4: do not check fast symlink during orphan recovery
      commit: 55baec0cc241121974e6655895ed0a5432c09059

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
