Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9B2D6E72
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784525412; cv=none; b=Hh7b4y3rKtqLNR0WMAqagVS1LnUMsL+naF3r3ORiOnGL4BXA+d6We5MQePbBaO6Ec6l0zmtXtfnFoIB2Q7tb3cHbAFvzAVLMqr1jHQvtqQv6KaQHItOejZLjrn5VDNjGU2kjV8Thv/kW0XIHr7UcDyLFJqRbW2wOeHaWxyHxc8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784525412; c=relaxed/simple;
	bh=YQpy24MaXz52EsBUS6416YoTLpCMJPYbWsJx/GnjCYE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sINcSfILrLGYLcrEj8nhm9Z1dSPFTWM0KOxDhsDf9u+ZF0oeHEcTrV90TNEm6AbdsdjSveT5m0q+fme3o92dXZvMJJDO78bWCLxSjGBcuYXf9fq6sbUjUvQ1X/L80NDeKlCZdZcuVcfhx39QFrYt+4n/Uavf3XnCgL9Y540jV5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CrjiPVEQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CrjiPVEQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC87D1F000E9;
	Mon, 20 Jul 2026 05:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784525411;
	bh=KUTjJ7TAtZ9PryXizZrAnM48pnSQ1wB+EIgKQoSKNGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CrjiPVEQlLqpGI/wgwzQ5ssXg4Bz3qTdYTz4saWXQIfSgQtzeHIHQ+BoSc0elbnok
	 KxwMYXrYLxA/xag4WTyJfHBjKLkcVX4SpaBN4N5mKynfdtlVcBcwz0yz5KzjLIhUvu
	 ibq6m4hogIqiCGZzN2MnFgvFm/16qGFu/D8IhFdM=
Date: Sun, 19 Jul 2026 22:30:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: <ziy@nvidia.com>, <david@kernel.org>, <luizcap@redhat.com>,
 <willy@infradead.org>, <linmiaohe@huawei.com>,
 <svetly.todorov@memverge.com>, <xu.xin16@zte.com.cn>,
 <chengming.zhou@linux.dev>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>,
 <sunnanyong@huawei.com>, Luiz Capitulino <luizcap@redhat.com>
Subject: Re: [PATCH v2 0/3] cleanup for stable_page_flags()
Message-Id: <20260719223010.dc6851665fb226c73948c69e@linux-foundation.org>
In-Reply-To: <20260720033021.4091944-1-tujinjiang@huawei.com>
References: <20260720033021.4091944-1-tujinjiang@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 11:30:18 +0800 Jinjiang Tu <tujinjiang@huawei.com> wrote:

> This series cleans up stable_page_flags(), see the details in the commit
> message.

Thanks, I'll await further review input on this series.

AI review might have found a couple of pre-existing issues.  Arguably
both are around the page-snapshotting code:
	https://sashiko.dev/#/patchset/20260720033021.4091944-1-tujinjiang@huawei.com
