Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFA3C873B
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784540726; cv=none; b=Gr0X+2cN3HoYXUI64qASkHbpc/xJNrDFPfIdJrYZSKhLh+q6n4QpKdX40q1AejRI854I2nP0Ops5GPsGVm/i69mACZCZgtBv4M/NfaUFTlFsbTNGWH1Wh8+nt3wgU2Dmwx3TdQfH9W9PXgSaeBQJc3CaGP9kjyHXn7JEU3vu0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784540726; c=relaxed/simple;
	bh=DepFgT8Pdjn2Dr4NdCjwAlzufKmqJeK6q/AHDTvu4Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhStRR8tlDIHG/Wby1HF9rFUbQnup2ZQUdPFgx3XyHE1jTOEP04RdiCtck54CHEMfCtAiZSgM1vZUbd2vsY7DSEqUa0G+Rbh8t9g3vykihofRKu6PbabvU/IOB0NA4+vrCte/rwxRQYlhWPKJVZPSJ5sOllO6jooUXxzrDDIhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=muWdNO+0; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="muWdNO+0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784540713; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8MwbgXwZ3zMaHcDnJViuu8BS+HJvN2qfbWu5++MyV08=;
	b=muWdNO+0d63NPUZkB1dEKN9rK+z98Sq7U+UtPVfPWiZvDqUCPgtYiFEGuLDON7Eg8/Yfhn3s38fiEMCsPZaYDuJSE3ZiMhHPjThY2bJNRwe/8lhENPTWMru1dGbrPGPv9oK9AfqgSZatM2GZbkLZbnpnRibjW0OERK802YM0thY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X7S8pq3_1784540712;
Received: from 30.221.133.33(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X7S8pq3_1784540712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jul 2026 17:45:13 +0800
Message-ID: <d8230340-0b06-470b-9195-ef9942b1004d@linux.alibaba.com>
Date: Mon, 20 Jul 2026 17:45:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org,
 Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org
References: <20260717134147.1602735-1-gscrivan@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260717134147.1602735-1-gscrivan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/7/17 21:41, Giuseppe Scrivano wrote:
> Allow userspace to pass an already-opened file descriptor as the mount
> source instead of a path string.  This is useful for tools that already
> hold an fd to the image, such as composefs reusing an existing erofs
> backing file.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---

Looks good and tested:

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I wonder if Aleksa and Christian have more comments since
anyway it touches fc->source, but I will queue for the next
cycle if there is no other opinion.

Thanks,
Gao Xiang
