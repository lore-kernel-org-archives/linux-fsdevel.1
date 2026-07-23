Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7932B12B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818015; cv=none; b=llNvHaAwi6RsGnpORldPrLP5Il2/LJCj1z+FPQE0hgXzpHGgllho7nglfNrx7P9AOJCvFTkW6if6wuQriETmjU+p0PgplQQdxaPV4L9Z1O79E6ORxCdwoorMGGP4uD3IFRVIlYBaameCMtjMPYcM3ncdzriyEsTaUivvsA89gfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818015; c=relaxed/simple;
	bh=LDQpyaLboE5OxsAw5Npt9mA3NF0xevJpMGml9LKT8aM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=qWp7IKwaEl50mvv4tSCRqu5/YnszcAUNSRKdLoSoikjRFIWfoVmRCMyMpiEGDaCXmANWYbbbo3zJjw1Ha2wcHMuBxK6WulfRBco9a0wVu5PEtWWZwXWLy5v17MYsVjtOgIVuYucVoDh6M2uSxOEKa5BoGrIvTxtNAQ56RUJtpk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFac4XbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFac4XbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653EF1F000E9;
	Thu, 23 Jul 2026 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784818013;
	bh=04rJgth8C2nU396fmhBsL9Df5jNE4GqWoAm1aGz1NtY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QFac4XbW5BKnsGW0VCewkPEY/8Pk4UmgqpR4wknbIWl5FvQTLvc4eQn8izREcKJSd
	 lkklQTQrbyQskcRZiqZ9PFBZjA7aVqpsgW9dlDDoo7SCYz3GQTuUXgO1hjbUbYf4cl
	 Fyq8m6SUHTesS5dEiMaw4Bs+LD0k2RruNNQAThWRYsIwHkqKGfa+oMNw280oHyD+RT
	 bCUh6UTNMKIF1fwxvYmhVFPbz/O7MnT5mwNxZN8p/UJ1Q3Dp0EPFfHbTimvr/efE40
	 5Q/x6Igrd57fwNMbCTNNK1/M9BR80J0skXfSn6/Wl2Baw0BQukfjHiAYokr7baMtMo
	 /1f+IA1R0FoBw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] erofs: accept source file descriptor via fsconfig
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org, 
 cyphar@cyphar.com, linux-fsdevel@vger.kernel.org
In-Reply-To: <6d1ac697-d5f8-4952-ba68-27610f17bf3c@linux.alibaba.com>
References: <20260717134147.1602735-1-gscrivan@redhat.com>
 <20260722-notnagel-allemal-kampfsport-8fd4e4d98a15@brauner>
 <6d1ac697-d5f8-4952-ba68-27610f17bf3c@linux.alibaba.com>
Date: Thu, 23 Jul 2026 16:46:29 +0200
Message-Id: <20260723-wickeln-schindel-rotstift-d987d4e9c036@brauner>
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LDQpyaLboE5OxsAw5Npt9mA3NF0xevJpMGml9LKT8aM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlacY0zjCbcrjj7duUbCZHhfXiK2Lz0w7vmD5Z6NtWe
 Z0OZS6XjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn8LWb4n5GhGvGAgX3Ky659
 nFHnuaOrpUpCNxzqYWec2c8+9327EiPDkqdB6mk911ccuHJEMab26PcggcJVLcqCf9hmewedi63
 kAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> I'm not quite sure if I catched the point, I think Giuseppe's patch here
> tried to record `file` into `sbi->dif0.file` (which indicates the primary
> "device" later.)
> 
> And if `sbi->dif0.file` is set up by erofs_fc_parse_source(),
> erofs_fc_get_tree() will just use `sbi->dif0.file` instead of
> `fc->source` according to this patch.

Oh, so you only do it for file-backed mounts. Do you only allow regular
files or do you also support block devices with
CONFIG_EROFS_FS_BACKED_BY_FILE?

Do you document the expected behavior for the file you're consuming?
Meaning, are concurrent modifications supported and what type of
behavior does this exhibit?

> The reason why `fc->source` is set was discussed in the
> thread of the previous version suggested by Aleksa.
> 
> > 
> > If they close it before this means you can mount something completely
> > different. The other thing is even if they keep the fd open someone
> > could just rename the damn thing and fc->source ends up pointing
> > somwhere completely different. The could switch namespaces as well in
> > some circumstances and then it points again into wherever.
> > 
> > I've played with that fd idea before. The only way to make this work
> > correctly is if you plumb this down into get_tree_nodev()
> 
> fc->source in this case has no use in erofs_fc_get_tree() (`fc->source`
> is just used for mountinfo for example), `sbi->dif0.file` works instead
> I hope I don't misunderstand something.

No, I misunderstood this.

