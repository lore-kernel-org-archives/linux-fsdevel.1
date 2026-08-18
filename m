Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131A34F46F;
	Tue, 18 Aug 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787040011; cv=none; b=Mhzah2rVZCpRUYp0vV0+lgRYXFS5OYv9aaokw/yE+3w12PwCLpr2x4krlKuNbiOgCUX0LJ9bIzLPFexmyQFyrhgucFZ9DFRUkvEKps8SGDOdZZV+VXEO6FUfkz1jJAtPGIFEUeJRjB6KNGfoYpgd2N0xP4/OcTivYIQ1XmcNnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787040011; c=relaxed/simple;
	bh=U78bzteQushEn6RbPE89a/T42tRXztjNQs4DgK3UpWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mzt5l7ZtR505mqaHbwJSuLDHzHNUWtJVPR69nC7UwCJNkUg7THLaxdjQ/7w0YZCvSCjJ54n8FejSFKu+YD7jFldItQIuIzata6CC0BX5y39I8UM5EXq95hpfCQrm/vfnclWhJq9KNdftmVKjpgyo3/7YY/6Fy+15oVRCgakRiME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DBJg7c39; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DBJg7c39"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787040000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5SWnt1XgRkD7NxU+b5BCzrBPNzdTrRIBbe8YTfvgRX4=;
	b=DBJg7c39emJu+Qw+UfMhx3Zc8vi0AFKOo2eIwTwUhxRsCbGUxzHBknqt5GVvUR2twTg0BRIu4tA1sZDDMU5HPGCtQH4Ad61qYKlsaljsVtxPZTbGDurRB5HUfJATQkoWutPHU6futv/OoMixxeJt2hdZ40/H8e0EKROc7btKvuQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X9CjKUU_1787039999;
Received: from 30.221.132.72(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X9CjKUU_1787039999 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Aug 2026 15:59:59 +0800
Message-ID: <4b0dc107-f9fa-4e84-9a6e-f1fef12d56c9@linux.alibaba.com>
Date: Tue, 18 Aug 2026 15:59:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cuse: wait for pending RCU callbacks on module exit
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 jefflexu@linux.alibaba.com
References: <20260814134015.618488-1-libaokun@linux.alibaba.com>
 <CAJfpegvKQrOGAFCDidFeELrQb08sebJVo=WHXB5SoWAwjodSKA@mail.gmail.com>
From: Baokun Li <libaokun@linux.alibaba.com>
In-Reply-To: <CAJfpegvKQrOGAFCDidFeELrQb08sebJVo=WHXB5SoWAwjodSKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Miklos,

On 2026/8/18 15:33, Miklos Szeredi wrote:
> On Fri, 14 Aug 2026 at 15:40, Baokun Li <libaokun@linux.alibaba.com> wrote:
>> Since commit 053fc4f755ad ("fuse: fix UAF in rcu pathwalks"),
>> fuse_conn_put() frees the fuse_conn through call_rcu() rather than
>> synchronously.  For cuse, fc->release is cuse_fc_release(), which
>> lives in the cuse module.  If the module is removed before the RCU
>> grace period ends, the callback jumps into freed module memory:
> free_module() calls synchronize_rcu(), so this should not be an issue.


synchronize_rcu() only waits for pre-existing RCU read-side critical
sections to complete. It does not wait for pending call_rcu() callbacks
to execute. The callback can still be queued when module text is freed.
The rcu_barrier() is needed to flush them.

Many modules (including fuse itself) already call rcu_barrier() on exit
for exactly this reason. Documentation/RCU/rcubarrier.rst also explicitly
states that synchronize_rcu() does not wait for callbacks and cannot
replace rcu_barrier().


Thanks,
Baokun


