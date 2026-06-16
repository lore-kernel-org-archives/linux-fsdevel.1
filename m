Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC853BFAEA;
	Tue, 16 Jun 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621693; cv=none; b=Vj8Ia/1rKquVsQj126ROdKq5XVTXQX3Ne042kE2qBXHBOgVdAT2Si6EAN7JAUxq/C97+S2oM6L/82UevgvHCRVbla9xXVyT3cSYdy0cCOK4GuaqN5+svfpWLBvy9JNxA8WXUbO40TlqwMbf4h/1DjDbtHuUTgUDX1OoN7LFE9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621693; c=relaxed/simple;
	bh=VjfeqXAniXGqPvbJ2MEBY91CQUvsbeEp8zUrFaZwn9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=td5BR919xqXeoSoG75WglQ/nE78+XIHFGQFrEK7a0twqIxt7asFcHrz9g9kgDBFU+ltGUb33vxzXC8jqFCLCLZIoJueBG7Pat9GXraWAEsaJUn2y4weDwK2tPIB0vMtFcDr29TtzGklxdeOy0iXbuKmzN/lq1MrmR+kOy8qleNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=u2mTijuf; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=xqgelXa6; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="u2mTijuf";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="xqgelXa6"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 1035426F7662;
	Tue, 16 Jun 2026 23:54:48 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1781621688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbn6Im4A4xUSzYNKCZmmUfjg0NuEYnIRJ7B6o+ryiCs=;
	b=u2mTijufUHlyC63hSIlkzooOZOVCK+Q1uQw8ZEikHAi3iLOuT+VtvHr9uye2zx9VoxfjhP
	tZdwWtE7OZR2xwkEDqxHnurq1nLPzMG9RxxnKC2cdec5ehAtj7Dps1GIg8nENq2dCsiFm5
	u7EFa12MfwU3wthmsZD6lopIKOJNkZUWhUF7Ch+Ym0BNalJmHIo4mI4bnd1In2XjOFSpKD
	odEgYFW3jcfcRlH1CFM5cwvBovYPta8eU7z/kI+0kCOM/39K8gSAhX3YR364n6d5iWfQvq
	28vAEK82awGV5raqS8r38yYU5guv560sImYvCq3DmoWLjN9MtpG6Hc/V2k3HbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1781621688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbn6Im4A4xUSzYNKCZmmUfjg0NuEYnIRJ7B6o+ryiCs=;
	b=xqgelXa6OVwJ3SuWa7CWJ7LS21spbi2BemG82n3NZ/oLqXTD202GfhE6lFVL/cYYGQ/znV
	KhWrS61MqKXQb5DA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 8DDDFE0007B;
	Tue, 16 Jun 2026 23:54:47 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 825E82200085; Tue, 16 Jun 2026 23:54:47 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Timothy Redaelli
 <tredaelli@redhat.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v3] fat: stop reading directory entries past the
 end-of-directory marker
In-Reply-To: <878q8e699i.fsf@mail.parknet.co.jp>
References: <20260613172816.18034-1-technoboy85@gmail.com>
	<878q8e699i.fsf@mail.parknet.co.jp>
Date: Tue, 16 Jun 2026 23:54:47 +0900
Message-ID: <871pe65ydk.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

>
> There are some strange behavior though (e.g. seek after name[0] == 0,
> then readdir()), the strange should only be on already a corrupted image.
>
> Well, if we found a serious issue with this, there is possibility to
> revert later though. Looks good for me.
>
> Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>

[...]

>> +static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
>> +			     struct buffer_head **bh,
>> +			     struct msdos_dir_entry **de)
>> +{
>> +	int err = fat_get_entry(dir, pos, bh, de);
>> +
>> +	if (err == 0 && (*de)->name[0] == 0) {
>> +		*pos = dir->i_size;

I re-reviewed this part. Since here is failure case, so we have to
release *bh, isn't it?

		brelse(*bh);
                *bh = NULL;

>> +		return -1;
>> +	}
>> +	return err;
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
