Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102357;
	b=bUeMj+AK9c5F1iEDh6QVPorT4Lq576mPyvoHw2+4WQdFebUsZVIFzzD8OVwCc26Hex5H
	 lHZ4BgvO3VM17STv3TXYwJN4fhAu+gSlbvvrrewiTFSxe0cBSee4zX4Eu5IXSw4hrIo1m
	 1tpYD/gyDB+ALAn0bWUgvpUUinQJ+eYWgJQH4+VQUqtgbgLvQbatYuBl9C5V7SIaGYCU6
	 xYlTWMplVvjZMt/8N8+L2/pREAl2MCRv7dDS0gVOD0A+2aRwzsCeoexisVzPpzTHNENho
	 skCJ1AeSup6RsIpOwV8krw+8yuzqLVxvf67NSqv+P6GFBAYsJYSjgNUMjvHumNtmeiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f7T2TmAinoSSVrUkDLWCSHpGLO0VMoU6RTqJIGDHf8c=;
	b=KDGIn3QkXhlU/V+Tjd6Lm/dXdz2wUDrR1CRN1n5vA6po/FfhIwOT7YfAPU3C5N7SAoU2
	 XcInvVa3oMoOPsfODzCzT+2859xEaB2r/q0ycGH4VRQbsDMwBahkI/HK1XG9jPdY2/9KB
	 mlgbwbyvOWInGbd7DMEbcsKPRlXseC8oKCtCgXLFqgohKDogTD1r/TlfM7gte/lSUsK+k
	 m4IUkq+jE7fw60XbJY4km2ZqNZugYz1nx+Bv6ZximqSeOnX89WidO2jsNaRzcS5E/OnUI
	 N/arPpows18BG14RTw9EaQ7u1On5MO0yzYE7c/D/fYA9cpewY5ZPSVeUy9jxHp2vqxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EriZpb1V;
	arc=none smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7FD60A2612
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 15:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D7FD60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EriZpb1V
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ae25c9f857so24095871fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795102355; x=1795707155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7T2TmAinoSSVrUkDLWCSHpGLO0VMoU6RTqJIGDHf8c=;
        b=EriZpb1V/2zno0fmMO54HL34Ty+nBUS/4UO0C6MvrvxZFEYE5Wk3AXr9C+UsTd1EKu
         e7VRl67WTxEo3VDt+hkZtLmFiEHnR1zJiLfC/Bq9BJKAFBDFohxqHF5Q1gg0wFZRWOaP
         GGmxEOrPJV8MRv3PkF03h/86SpZPKw+8KkyhjjjSRymeueMiKP4mQ8rtd0qNdqm/fzoE
         MNeg/d90yqGf1ngIGXcTcG1X2LenLIoGjIMBxdm9LKyp4bnMI848kU3NoOJqH9CbrAin
         fitPeVcUyIY+ve4q72M8iKNlPUyICj34RV6qW8QMN0CuPmRvl1c9rcr7e4C4EfPjdOm/
         0D9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795102355; x=1795707155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7T2TmAinoSSVrUkDLWCSHpGLO0VMoU6RTqJIGDHf8c=;
        b=xC8hcr1qRl4r1Fhe3w2zRvQ709+gnPruvJhPUwg383O3D5id2gJzwgBDBLBciP1hOd
         /25B9w5SqEkYpWJviDFIuGITtXfUwDaLe418XcJmuZg1J21xz31GM2pcAjXgUjYYiczq
         FFJlrg7cyLhI5DuqdQ4vnX4byo+aJH1JdZtrF3T8UkhXV0H70vQZCebvcrqfHvJuAuQC
         CxPTnZhjwPYsyU6VctSZWm0Zo5DP30P8Y7iUeblZXCmcIpW1fmLAD4N3GHGpWdsKFgM5
         gjviMF5UnwJfw+IQh5Dp3/Xexl1DOWgs6KreO85g7iNoWKKrDDbwSVxfPpgKZfUJqL+P
         6+Gg==
X-Forwarded-Encrypted: i=1; AL+hErF5j8LnTzg8Hl1S0NRDDxQnr/jBirkuCcO7FLXd56I3bWUMkJvUWY8f15LCQ27VmdrSfXxC7a1+ju3mpymY@vger.kernel.org
X-Gm-Message-State: APuU4Z9L04x9w6xtLV/SS2XJiC7cIksZRZ5W2MIOf8NJeK5LoTpu1r/l
	ZcblLDtpoxSfCoT1byMhDb9j45ruyKm4JMli0fbs0TzWDpdnkvvPKrGz
X-Gm-Gg: AZFdTZcf9PJ5LlfVASI+fZ7OSfXr+7tThQM24nT6pS3Cqi5wQagd+kckksip7U/Coo2
	eCjba6ZYkpvw+SE4LKs+FQT0vrjeFI8/b7C9Yr1lkUnzfgja3Ve97AM81oguC8iiYJddaclBwD7
	NacAsrm6iuBk3hxdXisQkZkUZ4oFq1etcb5OXOo/oS4py8K+eVdft1ZpMq1fYKg1ExdAMN3ia4Y
	3DBKbJZYWxF/0yAc3bqS/QTbKdaTEl0wSENR8DmhKHUQX35GCYJOzTbLSv+GqD7T/WOT94lNBQm
	j1sOVhW24XdnhFgGwx52eoN+rL1etb+GUuDdgahNltpds38vxtw1IPtaDtvbiqp9uKYTlX0/BSF
	sjHkbO/Vn6IhnSkGj0vGMfwEG/Bv+W9UvlNKZNhQLEOYp2/CkPqS7pUbPWdKRJltx1iFDwqnPc1
	xtWOrJOe/+HsM43d4H2HpkNBTXMbSOL/uE13/Vag81g4SSksa/zn46sa5+ElhNpdMdYSwRcAZpl
	FeQjrQhhZQ9amaJUfGoRqecu3BtsHv/rkEBdBayjiDi9qUT+RjnNQddQIYSlYQ2gQndJwOho8lO
	qXFNTzXBt/V4PYReedH6zh8AFZjsglwqAOs+bvoa94nP4KD3Xd685nZwhz3naeDW241nEOOS0dZ
	tBfQdV+W+AtPj0Bfd8OFczO0Zs/SQOlOn2OrthzvVBz8Y2Mdtck0DztUCQfQ=
X-Received: by 2002:a05:651c:a149:b0:3aa:ef31:e51e with SMTP id 38308e7fff4ca-3ae7fa644d5mr1204161fa.19.1795102355312;
        Thu, 19 Nov 2026 07:32:35 -0800 (PST)
Received: from Lauri-G-Pro-14-M4.intra.lakuz.com (n2vuxegwnwppvr5uhf9-1.v6.elisa-laajakaista.fi. [2001:99a:2ab:bb00:c16c:a39e:e605:54b5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae6ebe67e2sm11532121fa.33.2026.11.19.07.32.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 07:32:33 -0800 (PST)
From: Lauri Gates <lauri.gates@gmail.com>
To: koraynilay <koray.fra@gmail.com>
Cc: Dave Chinner <dgc@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <christian@brauner.io>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: Concurrent FIEMAP on reflinked files serialises on the AGF buffer lock
Date: Thu, 19 Nov 2026 17:32:22 +0200
Message-ID: <20261119153222.65195-1-lauri.gates@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <DMZ4VQ7SZ07T.29WMPQ0BQZGSS@gmail.com>
References: <DMZ4VQ7SZ07T.29WMPQ0BQZGSS@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 19, 2026 at 01:00PM +0200, koraynilay wrote:
> It doesn't seem like an FS_XFLAG_NOSHARED flag would touch this new
> change, but I thought it was worth pointing out, especially because this
> patch would also add FS_XFLAG_PROJID and a new FS_FILE_ATTR_XFLAGS_MASK
> to have a way to include both legacy and newly added xflags, so
> FS_XFLAG_NOSHARED would maybe also go there (correct me if I'm wrong).

Thanks, that is useful. I agree it would go there, whichever meaning
it ends up with: as a newly added flag its bit would be added to
FS_FILE_ATTR_XFLAGS_MASK next to FS_XFLAG_PROJID, since your
fileattr_to_file_attr() masks the value with it as well as the mask
bit.

Your mask also changes the question I asked Christian. With it, a
plain "may share" flag works the way stx_attributes_mask does: a
filesystem that sets the bit in fsx_xflags_mask answers, and one that
does not (btrfs today) reads as "not reported" rather than "not
shared". The inverted meaning was only there because file_attr had no
such mask.

One constraint for that case: the flag has to stay out of
FS_XFLAGS_MASK. As I read your fileattr_to_file_attr(), every bit in
FS_XFLAGS_MASK is reported as supported on every filesystem, so a
plain flag there would read as "supported, not shared" on btrfs.
Outside FS_XFLAGS_MASK the flag is also never seen through the legacy
FS_IOC_FSGETXATTR, which masks with FS_XFLAGS_MASK. That is fine,
since only file_getattr() needs to report it.

Christian, with this mask on the way, would you take a plain flag
(say FS_XFLAG_MAYSHARE, "may have extents shared with another file")
that filesystems advertise through fsx_xflags_mask? If so, I'll build
the RFC on top of koraynilay's series instead of using the inverted
FS_XFLAG_NOSHARED.

Thanks,
Lauri
