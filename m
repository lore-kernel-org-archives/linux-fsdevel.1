Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C73932D5
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733873; cv=pass; b=I+m8NTxN46wqMoq8zHB7nwCk2M8YceDnmEykKncLHcVL9mzxpnWRJcQyWK0RBwYMHOejsKgnH+E39OJbr2oKkO3+S9FUjVxQRZfpNm4Q5Sw2An4aw0tOSfS6JJ+/J+Ug6ST21BOhksKIS7po1pC5r2CGXJkcBhgfLsFKh67peqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733873; c=relaxed/simple;
	bh=FmqQi9tHDOGtMRA8eYccGrCqdDwhdIqG1ghsXPY1Uts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NW54sbgj/DuX/4XqNKKAFilpIQXSTHgKDPo0HiguoBCNEMji3Zfz811Ek55r0VNJcw/vS87jG0kghiGjF3uPKmY2Twdge3MDeK0ZP1FkGy2agBl1aKokv0WXDfnvccLegxodWqWmbICBpxCbT5qYDMfTDaidWngRfvih0Fbklb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=id3l4Dsm; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="id3l4Dsm"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e50a650a0so764749985a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 08:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733856; cv=none;
        d=google.com; s=arc-20260327;
        b=PxihdJ1xEWTUR82o4HPkEkC0cxg1tBDPDbKNfGRoTj3YfmOL0/6Mwuz4GkRj0693PW
         Glz3vtfnH8ju+v0HmiNW/npWEtgkVI0eHhX43B1k+PrGlvD6LPGtRe0XPoB6v9q8/pfQ
         jt2AjXlBEKmxUnW2tCjR0MgJeUDjOqPEwEWpafoqL2C0Xzfdbg4OI4JsTHsTgoijW8Qo
         FQ1ynDmjmuKOxsTmHJZjv8eXGM4Tk0jTgmXzLKJSO/bnXNi7hnwLolnFUX5JvdbmoAAL
         z548xzfEcYPE/gPLJmoSlQgD72qESv2qjJMz0F18Cyu7CvlV38G2jugEO/UQ+sYlTZdl
         dVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ff8+sJsygEDuStaVFp2hCNrsI9M5jePRaYSdvrv4X0o=;
        fh=vsvcadVHMkUMgrtB5fzBTfwcoH+2+1y+0EPGkeIQxw0=;
        b=qpPq6H4wC0PTPFRfsBSyDDWO2ZAcqSkJ20fa9lcxbuPADqcsoqcx2twy5AgmvQjJyz
         O0nx5NjYLmZMLL4lSB66E0gu9XSADdt7q7HHKYs19r30dJ+4FcrPHElBm90zPJvKGCql
         FvDzrKj5OdlXjtNMJzflhD4zCmu08AN4WoPuYZ/RbZ2qiMDQrOJARyZ3d1c7VLlZwpJo
         l+42E1pIOvD/cJi+viEXi2HVFIk9HPhfN8ej/Y68B0bkVbNxbuuvUh3C4Uhg9C9T0gAN
         p1Qc59JbMjWgsBsncoycR8d6gLyXuCj+23u6GOwR1mUzDQ419TNq6yrCvnmMw8apC9x2
         xYXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784733856; x=1785338656; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ff8+sJsygEDuStaVFp2hCNrsI9M5jePRaYSdvrv4X0o=;
        b=id3l4DsmZgREBbR6h/yxiO8eKv7LGI8EgxPiuuBbKGEHhiFxQwAxjladnBswED/Qmw
         Ax33XN2mHBzIUzHztECMTaNs72eqwSZtXmZaaifQAOiIk1JvMm4VNBEOaCCSeomIAJO0
         bmRifZH5PIDCqagNJN3TFMKqmosgxKwkzoa5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733856; x=1785338656;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ff8+sJsygEDuStaVFp2hCNrsI9M5jePRaYSdvrv4X0o=;
        b=I8bQ2bDeYoVjxm6K7lDuFVm514MofzgbFxm8TK0dkwb8DC3Dpyi6/1jvcB4bMxq/H8
         bj6r40wnetRTOXKLwSfPBOcnzD767mndZtxOoSvjN+LkEOUo/HWWG16hnZuwfI/26KdS
         UWAmH/Tu/fyZAjkBOncbYot6+KvsFIi2jZvahip4cCs2UXgilWIskrwf7pW8bxMONl5f
         F5g2Mw9FWWaqDR8AD1xEZkqoREpxgHh/QFAM1IcA14K2LJMO2sEL1pCZzG1ejRfJbSDz
         3enmW97/4l4weIDm2h+q1/XVeXmFN0YmaHVz5RoQaJxWf/XkURmEkCUj6UDTPrEGH8cl
         EHig==
X-Forwarded-Encrypted: i=1; AHgh+RoCTp3wxllBEnvKmRLyynDTfQHujYnWQMUy/X4y2boVOCarGepaF4iFQj6qkBngNRKkgUzl4YXBopUwCjGT@vger.kernel.org
X-Gm-Message-State: AOJu0YwG/KCK4XOgOWlerg6p70QGu1CoFqL3zhpaZEBLcQ35k1EQqCkV
	0yXLPAuISeJbn52E4/aTPAcpASmUguCkbFDsKEv4dX05KzEz0wiGPbK6GdefDBeBGYq6ZpNm9Hz
	zlbVogp2iEzkWei7pbZMzbHj6rwMLPe+yP1w/j56I7A==
X-Gm-Gg: AR+sD13pgzHSe1koZnuRslAe5xxcLYvNB3+a+5AbiwPkp2lOnLgjpPrBDPlMY2NuAFC
	emNA02zLpWK7cW4D0claWQbcyW7Uw5tavcdLjbWd1AGO1gCk9VhLWVb6HNVoW8DPHwZIDNKhgrJ
	7zy6qmq8XSVpDv1anx2EmhxGq67VDjAR1HcFaJ6y+atmorIvT0VsA1VtSasXKe9jGL9xHwfBBf8
	eoZvvr1VIaknMnk1bV1YEt7Dpe614O2dIRQdWL2WtxAWmzEw0DRJN+EeFZAeeS3GtW4G81biteQ
	iDggP/Ajak2BMc64yQ==
X-Received: by 2002:a05:620a:2844:b0:92e:9cb3:3f71 with SMTP id
 af79cd13be357-930b3ed66f6mr2281752885a.36.1784733856139; Wed, 22 Jul 2026
 08:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034553.68798-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <0100019f7da174eb-4cd0f3ae-59da-4533-b469-6eee009a22bd-000000@email.amazonses.com>
In-Reply-To: <0100019f7da174eb-4cd0f3ae-59da-4533-b469-6eee009a22bd-000000@email.amazonses.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jul 2026 17:24:05 +0200
X-Gm-Features: AUfX_mxUSuw0ZWzZWiq2Rpl7efuyYxiFK3IBC4AQjtyaBV6Cq7Rj41foWBlGbSE
Message-ID: <CAJfpegvkbK4xtQsssn3yrdLn7zZRGB8MeRcauP8mbmJRCnFouw@mail.gmail.com>
Subject: Re: [PATCH V11 4/9] famfs_fuse: Create files with famfs fmaps
To: John Groves <john@jagalactic.com>
Cc: John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 at 05:46, John Groves <john@jagalactic.com> wrote:

> +/* Famfs fmap message components */
> +
> +#define FAMFS_FMAP_VERSION 1

Please don't use separate versioning for extents.  It doesn't help
with feature negotiation, so let's just use the INIT feature flags for
this purpose.

> +
> +#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */

Not sure if it makes sense declaring this on the user API.

> +
> +enum fuse_famfs_file_type {
> +       FUSE_FAMFS_FILE_REG,
> +       FUSE_FAMFS_FILE_SUPERBLOCK,
> +       FUSE_FAMFS_FILE_LOG,
> +};

Unused, apparently.

> +
> +enum famfs_ext_type {
> +       FUSE_FAMFS_EXT_SIMPLE = 0,
> +};

An enum with a single value is not useful.

> +
> +struct fuse_famfs_simple_ext {

struct fuse_extent {

> +       uint32_t se_devindex;

uint64_t backing_id.

> +       uint32_t reserved;
> +       uint64_t se_offset;
> +       uint64_t se_len;

Please  drop the "se_" prefix.

Please add more spare space here (e.g. uint64_t space[3]).

> +};

> +
> +struct fuse_famfs_fmap_header {

struct fuse_extents_header {

> +       uint8_t file_type; /* enum fuse_famfs_file_type */

Unused

> +       uint8_t reserved;
> +       uint16_t fmap_version;

Don't use, plese.

> +       uint32_t ext_type; /* enum famfs_ext_type */

Unused.

> +       uint32_t nextents;

Okay.

> +       uint32_t fmap_size; /* Inclusive of this header */

That's the same as outh.len.

> +       uint64_t file_size;

Same as i_size

Thanks,
Miklos
