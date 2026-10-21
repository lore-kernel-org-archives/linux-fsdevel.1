Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578693;
	b=XomA4XrhCm+CaZFDtjw37XJvB4Ml/OnnBsglbf9SmP2TK1g3eKoB6CaaaAmu6paT0Tke
	 /a4MTD1VgPjVgled7YkvJcmKBp0UDBeSrL0gm3bAHTv4YXg4+3ljA16xDwNd+XUzCLoVX
	 0aE1ekfxQXXhUhL3Z/OicuG2F92oKdFMfhaCKUTNreTA6stzHJuzmFMsfLoTFCStzZ73o
	 jrZQqDpbJvK9eomfsfZRLQczsXpNfeDP1+yv+0RJyhN/oumICdvnzVt7Ag0cs+C54z/2H
	 D+npOTcFuJp+C1v5+fUR335R3AVhKstmdHlQIPgtY1pjiKZUtOarrgwIL1zaB2rdy7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578693;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=c3b3TnWcnKzBp8T51teiihVygdav0y33qEDBPEk97Fk=;
	b=SHmsOLaZtPu4UNnCCoMoOhuewIhPHBNlqQCJ45UOVqIN31/MJjvpQekhGV9yYNVrE56W
	 1zjHYSgCu3yd0MgSbEGys0MVp/sDs4Y+DDxnqFDJyF8e6M9RFhhRZywI1b/R8tos1jWNm
	 ORU2rPYHqGgAEcQsqw6+D8wlhbt9uRX6pg/YrlcILOJyOBmdE5zk8sAqdTBPhfWvEWidx
	 iaOOTUDTxIKrtkl+KlL7ElUkE1MgXIB9iy73AaJe98R+V3saz9c4zA8PH/cPinVBeqG1o
	 MsDjeK80Drhp9HbRw4+3ONbgZUjFRyqyX+wYvwe5cpcvkovccTTge7I3fkwPpWi967w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIpd4oo0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D14606A31D;
	Wed, 21 Oct 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIpd4oo0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977831F000C9;
	Wed, 21 Oct 2026 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792578692;
	bh=c3b3TnWcnKzBp8T51teiihVygdav0y33qEDBPEk97Fk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dIpd4oo0/aewWd/SIqeyGgal7YA+FpunfdnepCjfqkS/aC44UE7aC/d8Yogo7n/JB
	 u1MGl9KZsb9Oom0ASsarxDI2P1lwE80MT5QYpvW69BZkUSC4OGH4N/P836k7OqxjOL
	 RWq+/gzW5huTYy6+PTciBdqP2hRJW21gT9OEU4aEgqymFd2r7ml9UkdsAktUplCoxh
	 Earz7A/zQZLLUAPBalFyDuM7Qqu9ZNLpk7sowC0xPtbSIKTzgWy/4ln8hfj76CJODm
	 ms3aFJwHuTBNSLf29UpTw5/I/VV7CK+fPwmz4RrsvUlnrKyIUj+vA+KUiV44pJZPxJ
	 yV8LYL+5fiLIg==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tianyi Chen <hi@tychen.cc>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 NeilBrown <neil@brown.name>
In-Reply-To: <179240281988.1700986.8309527041821666235@tychen.cc>
References: <179240281988.1700986.8309527041821666235@tychen.cc>
Subject: Re: [PATCH] eventpoll: propagate wakeup source creation failure in
 ep_modify()
Message-Id: <20261021-bruder-chipkarte-entgleisen-676ef7e2fbf8@brauner>
Date: Wed, 21 Oct 2026 12:31:27 +0200
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=907; i=brauner@kernel.org;
 h=from:subject:message-id; bh=e55wevqlC/z6UepoUIxWg9JZ/dfBdv0vvelULXgJULI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmNLQFf8/+3Hnge+ili9XrbaLXiiRoZ8ymdei69Hiv
 QXTxb6wdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzknwLD/4z/tUtZIm0WWbKe
 Ufn27G9vixOzy6ko/QsGMi9PHjn/q5Dhv9dRlj3p88STeZ/WqK0x+DvNa5vDKYaSK9NlS5ab5dZ
 IswMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 19 Oct 2026 18:39:27 +0900, Tianyi Chen wrote:
> eventpoll: propagate wakeup source creation failure in ep_modify()

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] eventpoll: propagate wakeup source creation failure in ep_modify()
      https://git.kernel.org/vfs/vfs/c/4e3259b08c54

