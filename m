Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBC52FE0F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915033; cv=none; b=itGdMkfZayKtASA6pZ4f4ZGrjcjoU7YO6sqqBjK2sjMzHi0RF+Vk9MM30J/5HtFCJKw10Rp5cg9LGrf/Ky15ZS05a+AUigkmbUWTjXlnubeyc9ckGU0qQ1YKypXTTaSGV6SQXmBTNTSZl/tGOfhgF7fRVLiy2Miljcz6EPa5h3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915033; c=relaxed/simple;
	bh=2ya2ltWy8UiK7s8dXna3LgyyR63HRlRoim6UgpvwFTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgXmPFI331rVgNJP0kr1PvHwaTfJ3yVF2axJkt4pV0Vpn1GY26kq7Ce24FNFwYvwb9IxfpalJAbkPgmGWWDfiXsZMOpnkLKAXCJX3HixYszDOWD0P+pnvAMDpbtzzuM4yU3KHt1tBb90OzozZZ+GqgundFR5K3YyR1PWrY3Rrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wsiIlQfw; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wsiIlQfw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783915021; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ptapzLT2kC0FRZONruSP9TU30xzkIav8a6oiB+WjSOc=;
	b=wsiIlQfwcLNRxGUT08JjqhMSFEnCe1hWYWAsYZUkEllCEmGLylz+DGeEdW/6DMDJIptGb7Vyvv4XLfrcLerSVYs0qwmaJTuuw1Ps6jNsAR1Y+AEopzLaSY6IMbLWARGh8qZPYpgsMn8AWFdFG8abqfDQbcA5nlfc23Lc/Cxndc0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X6teBxS_1783915020;
Received: from 30.221.131.243(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X6teBxS_1783915020 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 11:57:01 +0800
Message-ID: <008358ad-beef-4086-a423-0b282746ebb2@linux.alibaba.com>
Date: Mon, 13 Jul 2026 11:57:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
To: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org
References: <20260711071137.4130824-1-gscrivan@redhat.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260711071137.4130824-1-gscrivan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/7/11 15:10, Giuseppe Scrivano wrote:
> Add fsparam_fd("source") so that userspace can pass an already-opened
> file descriptor instead of a path string.  When the fd is provided via
> fsconfig(FSCONFIG_SET_FD, "source", NULL, fd), it is stored directly
> in sbi->dif0.file and erofs_fc_get_tree() skips the filp_open() call.
> 
> This is useful for mount namespaces where the backing file may not be
> reachable by path, and for tools that already hold an fd to the image
> (e.g. composefs reusing an erofs mount's backing file).
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
