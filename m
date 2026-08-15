Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB0360EF3;
	Sat, 15 Aug 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809901; cv=none; b=ShC++RNUzuMBc+ncAFE5i9U6FhQHAfTbsoLgWvsv6u4Cn90Evf3fR8Mz6TcR84PWx77LJnIMloGEoIXlUiMC+fUf2MNoyVUzPdmDvOYTfyuLfZTkfayXnj0cAjCEGAyzPhyzK688qPuO04AqqIqC2T7g0FBU46vj6bkYYxnsgQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809901; c=relaxed/simple;
	bh=ZN/KEvCkLP1TQzzwwFEbwVX54Bpxpf0tYWDEQSuBII0=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Mmpg9FwIz6PqTyofq7DOkktk+JuPgmGu8PW9QeyP6XcUVacN5lKxrfY0gO2gBk+nqGBy+YZgYzZhSslcH9njLWEZ2VOkx51llL43BPNa58oBdSmvsLus1N/IsQVLlkEI2wkSnZgB8HC7Wqo7nvznfHnrN7SAtj7vmqESjwwzz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=YigGzi0w; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="YigGzi0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786809897;
	bh=ZN/KEvCkLP1TQzzwwFEbwVX54Bpxpf0tYWDEQSuBII0=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=YigGzi0wvpDq9QD9UPFboTR40v/VExuK9vNaeP+w1HwqFYZihQswEDxa/ragKczdq
	 W7ZXDRMBzkz0U2djN5LPlw76qJGR/TWeZBM5ett+VjAcMYDyEydU2v8mYDSjzdQY4A
	 XhKS3vnPbbBmpVR7BfNEfvn3vTdBjxTZPUL3Hz40=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hMkSn2mfPz10rF;
	Sat, 15 Aug 2026 16:04:57 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hMkSm5QTxz10qy;
	Sat, 15 Aug 2026 16:04:56 +0000 (UTC)
Date: Sat, 15 Aug 2026 17:04:55 +0100
From: Bradley Morgan <include@grrlz.net>
To: joel.granados@kernel.org
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_2/4=5D_sysctl=3A_Reject_uint_a?=
 =?US-ASCII?Q?rrays_before_calling_the_general_proc=5Fvec?=
In-Reply-To: <20260814-lklm-partial_ctlvec-v2-2-9df50d26e477@kernel.org>
Message-ID: <1A7C293B-4D12-4F26-AB80-7B903C6FB431@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Looks good to me.

Reviewed-by: Bradley Morgan <include@grrlz.net>
Thanks!
