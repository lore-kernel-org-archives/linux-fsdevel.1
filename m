Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27DA2FFDFC
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519152; cv=none; b=YddRvjCbDv7Q80xnwxrK1GGHqjhs+vBHHf0ZJauQAYHrgUuNlegd939XoyctFTuDrAkDoTv5jXTJmzNg80L9f5qUSUQLNXxfvZi8tdhEANeKywZ3tkSwva8nmybdLXBbiJQs8L9KQmgwu545ZGWNIkd9Fl7oSJ0X0VMN6dzZeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519152; c=relaxed/simple;
	bh=e2pbG5Bzr1WSgKCg8eEYEAL4qBLlTEhVNej7EWmvhtU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=a9BbtWyr2y8zq24GVunzlGMCWah4faHBAx2lsHRsgjpaN501vO6XazmEAavl+rJfMBFWnqmzDLK+xKAzfRFY54fNMfufnNVdFqGuZEESYzZOJqEVyCqTfxiBIWlEwpRN72l7HURl+zwVm4OYVHIvxHqN1myhztZI3mrW/mnHIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8YXbWjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8YXbWjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EA91F000E9;
	Wed, 12 Aug 2026 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786519151;
	bh=h6Zm1zIX24ULpA+dXIgBmTLKMYud3W/lb0PiR5af0hw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=f8YXbWjNz85I0rjKOs/T8FcosiWXHP6nGRcDaSztCKlP12HF2ckVIAgTtsmHNKokL
	 gysRAKddbaAREB2RXPjuvprFQb0cHRenTAlffdvuJUNa1ozNmkRFOwxRVzH9vl2ZG+
	 eLeYvggxYWDHG8elNrG+oXB1EM+l4161eDP80e+If8uHnVu07j54m2H/UqvfuGQZJU
	 tX1KCSeQsvCsyneRLpVeo1ngv9D/B/6gS/xxg0SCax+eKRTu+RV8g0IogOAgYEVQ5B
	 1WhW6Uf6Q+/fSaraUtzeoKnpeDxtITRzyOSfoIWrJwP+Cs+WB1Huftv7N9Lo3jQHvl
	 eZuflWZ3X2+sg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] fs: fix comment typos in bpf_fs_kfuncs.c, inode.c,
 fs-writeback.c
From: Christian Brauner <brauner@kernel.org>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260809192249.4485-1-manushprajwal555@gmail.com>
References: <20260809192249.4485-1-manushprajwal555@gmail.com>
Date: Wed, 12 Aug 2026 09:19:06 +0200
Message-Id: <20260812-galeria-kahlschlag-zucchini-a100e715d311@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=533; i=brauner@kernel.org;
 h=from:subject:message-id; bh=e2pbG5Bzr1WSgKCg8eEYEAL4qBLlTEhVNej7EWmvhtU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVyOVOPrj1xTrGfS+1t89eUyPiofzvzrItGVcsnztdS
 16WXrPmWkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBENqcxMsx9cHp7VxIL+6MP
 b8We/JFjP6Luat9tmN27SLzqWmDejGuMDAv9PxbqTVB4PO1gx96fn54nsNs6OTk2CixJfZddvGL
 /ZgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hi Manush,

> Fix a handful of spelling mistakes in kernel-doc and code comments
> under fs/: "Rmove" -> "Remove" (x2, in the bpf_[set|remove]_dentry_xattr
> kernel-doc), "funtion" -> "function" in find_inode_nowait()'s comment,
> and "paramters" -> "parameters" in the foreign-inode-detection comment
> above wb_wait_for_completion(). No functional change.
> 
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Please split into separate patches. They're very distinct files that all
received patches.

-- 

