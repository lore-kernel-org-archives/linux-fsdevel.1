Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036930E838;
	Sat, 21 Mar 2026 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078456; cv=none; b=GU/SBjoeqmfR672tPkgiwtGo+f9qR9vLRVgLz7GMiNGvLJpJugdj8ayQJuZye+pHpMUOD1ciZTU67KUseY+mCaojcykBCjd6RaUEgngzlVwqT2I0909EYeyS6gquz5USie4kLg4A7pMbLpCEruUXxZbI1Pt26nL219jLF9aUNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078456; c=relaxed/simple;
	bh=A5EME6yM3VZI8FbINS1LZeCW/DF+4WT21KbuVXPMb50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sI2n+a7flj9OrE7+OFD2oOtJPQRI+XyJDqQxsjyQmby4fKjRIdMrMJK/Z8pXJ/qb2+5FvFlu31iJUBIKw1tXXIUa54dInBV+/HzrRWKI61agp7iNSeQMAax7hOG0nIN7YnaGtPAwDjwzB9zLcr3adVLmZCF302wSXSUq2KlZ2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=VNlLHS65; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="VNlLHS65"
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 37c87d927;
	Sat, 21 Mar 2026 15:33:58 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH v3 2/2] hfsplus: extract hidden directory search into a helper function
Date: Sat, 21 Mar 2026 15:33:58 +0800
Message-Id: <20260321073358.1283192-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <381c1a738fbc47d7e6a81d9c2040ca95d8bb3b31.camel@ibm.com>
References: <381c1a738fbc47d7e6a81d9c2040ca95d8bb3b31.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d0f50ad6503a1kunma25a616028fc2c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSx5MVhkZSh1NSk9JTU9IT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQk
	tCWQY+
DKIM-Signature: a=rsa-sha256;
	b=VNlLHS65023IX0V89y/GV+5pbLdoD5kKoP03OPqXmXmCTonAaHOVze0dxmp0/u0H95dyYi267qXa+djMKPGBN6qJumOplkUSGzhdQAFlugwN94qJUHeR6FQwlCqvX3/fDoR30Wz5uSrpWSGnIvzNWuziFEqVxLzllDD/K4J2EcM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=7BUEeGOlcP/kgCOSSIQhCdub4SLgN9KVX7Ixqm//AhE=;
	h=date:mime-version:subject:message-id:from;

On Fri, Mar 20, 2026 at 06:40:02PM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2026-03-20 at 21:04 +0800, Zilin Guan wrote:
> >  static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
> >  {
> >  	struct hfsplus_vh *vhdr;
> >  	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
> >  	hfsplus_cat_entry entry;
> > -	struct hfs_find_data fd;
> >  	struct inode *root, *inode;
> >  	struct qstr str;
> >  	struct nls_table *nls;
> > @@ -565,16 +588,11 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
> >  
> >  	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
> >  	str.name = HFSP_HIDDENDIR_NAME;
> > -	err = hfs_find_init(sbi->cat_tree, &fd);
> > -	if (err)
> > -		goto out_put_root;
> > -	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
> > -	if (unlikely(err < 0)) {
> > -		hfs_find_exit(&fd);
> > -		goto out_put_root;
> > -	}
> > -	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> > -		hfs_find_exit(&fd);
> > +	err = hfsplus_get_hidden_dir_entry(sb, &str, &entry);
> > +	if (err) {
> > +		if (err != -ENOENT)
> > +			goto out_put_root;
> 
> I am slightly not happy about this pattern. :) Could we rework it in better
> shape?
> 
> I am thinking about something like this:
> 
> if (err == -ENOENT) {
>    /*
>     * Hidden directory is absent or it cannot be read.
>     */
> } else if (unlikely(err)) {
>     goto out_put_root;
> } else {
>    <execute logic>
> }
> 
> What do you think? Do you agree?
> 
> Thanks,
> Slava.

Makes sense. This pattern is more readable. I will update it in v4.

Thanks,
Zilin
