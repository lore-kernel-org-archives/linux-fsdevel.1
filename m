Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE231353ED9;
	Tue, 28 Jul 2026 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221256; cv=pass; b=p4xrHDNt5RApVe0g2dBtWLZQoqyRmFDl966WHNM14ERKtSS1KSdfTFtO9x1N85YyFdT5EfbN7LLfWbHLrXwk25YlIbAQBEz/TOtkqbYlQKqL8IGkAUbpvY26zsOBpDhwGWerHgecVS9KfLxfEMnWmWNGAqT+7wGUmuw9EAkxImo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221256; c=relaxed/simple;
	bh=dNc+iC79OCbfpC6hRBLPEIS1q1TRvgJ59CintKmDc70=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ax7ByrQFQKDn5SzAuc9cl7v2h6NyzEiU9BJkwnBAQan5trS9Y+36jnimSZ21DyJENpMe7ajJk7J8BNnMl7E88Dmz3ouSHmX8+DTHc3Yy67q9Vd1esW4SRUe1xtm1rCLbNuS44dXm3c+GO7NFcxIN/3y+bwj0LvJ8bdUWr8oSZwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=BQdwaS7N; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="BQdwaS7N"
ARC-Seal: i=1; a=rsa-sha256; t=1785221235; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TvIdN3n3nX9mesttuHRse35qquvmcLLWEew98rctnjXjYjAm+DZwqaK1EML3B0+017OtK4caSSdw7Lq9nc28nybi/oxIa3O2h6kupIBAhgwTV/CrPR3p6drj/KUgdN4zDAuuJEfnWBf0tdrpPFQDjcBdD74gdLPSSGGVIWxf0XE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785221235; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h+alo87DzsG/NLeUiBDtldv0Pwr6MX5W2jGl8AXZVoc=; 
	b=O+lF90tffZHLt8r+wHkezStq/EMIHrH5ULxT+hNek4ChVOjnykpMeUDBVXZ3hY3Dit/cBw+DTyYaAMRLZfpfj3VYvpZp7D21HMLCM5+9aP3kb5s+tFXFi9kOb60CvCxaunZ7oiMfARyEmFJMbop7XcAbaZaxatvW3vwyHCCtQNw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785221235;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h+alo87DzsG/NLeUiBDtldv0Pwr6MX5W2jGl8AXZVoc=;
	b=BQdwaS7NrKhO9iS40hf2njkXL6a9J3ZaCd8MtyeQKiO260RY7Fj23mzRT1DXc72+
	7DviC/WmkPB1YB5JRmLLOCl4MhgM3kl+25foSLspga6AUD31EHg99t5mnurbKGL96Z9
	OBsPHSgs9luEx65HTxBkTkZxHzsxBoPQGzkf5rk0=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1785221234853120.14539619974221; Mon, 27 Jul 2026 23:47:14 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1785221231290976.0786587549686; Mon, 27 Jul 2026 23:47:11 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:47:11 +0800
From: Li Chen <me@linux.beauty>
To: "Jan Kara" <jack@suse.cz>, "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Shuah Khan" <shuah@kernel.org>,
	"linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"linux-kselftest" <linux-kselftest@vger.kernel.org>
Message-ID: <19fa77a32a4.4055e8af2310651.5579113259972318429@linux.beauty>
In-Reply-To: <v2etqvlc6cq3al2pbdf43gu5b4d5f5py7dagkblbbt6mxltfro@kospd7xpqeyo>
References: <20260716052726.1032092-1-me@linux.beauty> <ks7xfhn7pzzm267bcfo725xwqa6famsv5yulmzgqt7hjdmepep@zm2dw2djd7yb> <20260722-esszimmer-umsetzen-nennt-ed5fc604300a@brauner> <v2etqvlc6cq3al2pbdf43gu5b4d5f5py7dagkblbbt6mxltfro@kospd7xpqeyo>
Subject: Re: [PATCH] pidfs: preserve thread pidfds reopened by file handle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Jan & Christian,

 ---- On Mon, 27 Jul 2026 23:57:14 +0800  Jan Kara <jack@suse.cz> wrote ---=
=20
 > On Wed 22-07-26 14:07:37, Christian Brauner wrote:
 > > On 2026-07-16 13:11 +0200, Jan Kara wrote:
 > > > On Thu 16-07-26 13:27:22, Li Chen wrote:
 > > > > PIDFD_THREAD shares O_EXCL. do_dentry_open() clears O_EXCL after
 > > > > pidfs_export_open() validates the flags, so open_by_handle_at()
 > > > > silently turns a thread pidfd into a process pidfd.
 > > > >=20
 > > > > Restore PIDFD_THREAD on the opened file, matching pidfs_alloc_file=
(),
 > > > > and cover the restored flag with F_GETFL.
 > > > >=20
 > > > > Signed-off-by: Li Chen <me@linux.beauty>
 > > >=20
 > > > Makes sense. Just looking at this code, what about PIDFD_AUTOKILL (a=
ka
 > > > O_TRUNC?)? Reading the commit introducing it 07c3ef58223e it appears=
 it was
 > > > never meant to be directly requested by userspace so probably
 > > > pidfs_export_open() needs to reject it. But that's unrelated issue t=
o your
 > > > patch so feel free to add:
 > >=20
 > > Good point. But pidfs_export_open() is guarded by
 > > pidfs_export_permission() which does:
 > >=20
 > > #define VALID_FILE_HANDLE_OPEN_FLAGS \
 > >     (O_RDONLY | O_WRONLY | O_RDWR | O_NONBLOCK | O_CLOEXEC | O_EXCL)
 > >=20
 > >     if (oflags & ~(VALID_FILE_HANDLE_OPEN_FLAGS | O_LARGEFILE))
 > >         return -EINVAL;
 > >=20
 > > and so is safe. But I've added the following patch on top which also
 > > splats if that is passed!
 > >=20
 > > From 99a859485394eca8cf6271de09ae72ac3b846bda Mon Sep 17 00:00:00 2001
 > > From: Christian Brauner <brauner@kernel.org>
 > > Date: Wed, 22 Jul 2026 13:56:28 +0200
 > > Subject: [PATCH] pidfs: add pidfs_dentry_open() helper
 > >=20
 > > Both pidfs_alloc_file() and pidfs_export_open() need to force O_RDWR
 > > and reapply the pidfd flags that do_dentry_open() strips. Move the
 > > common logic into a helper.
 > >=20
 > > PIDFD_AUTOKILL is now part of the restore mask in the file handle path
 > > as well, but pidfs_export_permission() rejects O_TRUNC, so this is a
 > > no-op there. But warn nonetheless.
 > >=20
 > > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
 >=20
 > Nice! Feel free to add:
 >=20
 > Reviewed-by: Jan Kara <jack@suse.cz>
 >=20

  > Both pidfs_alloc_file() and pidfs_export_open() need to force O_RDWR
  > and reapply the pidfd flags that do_dentry_open() strips. Move the
  > common logic into a helper.

Thanks both.

Jan, thanks for pointing out the PIDFD_AUTOKILL angle.

Christian, thanks for factoring this into pidfs_dentry_open() and
applying the fix.

Regards,
Li=E2=80=8B


