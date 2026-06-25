Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C1355F2A;
	Thu, 25 Jun 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373618; cv=none; b=QrDibWLcSZQB312iX/zQ4Zqj8SFCqCMZD94L+4hjeiGEwB5/eyGC0Py9q982sOUrQhL3s9LR8NEmyofxl4NkJySiKy9ZtLx0SP9ulYtIHbc1epzjqn3pmf/TFwDBWNfOQbOJBUMYJG03pHY823JoUE5C1WqMPpsp42+dC5a9NnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373618; c=relaxed/simple;
	bh=7Ko7l5j62juXmtEEmF88xJJP/vihMyfnZ2pdrPKmOyA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=J79BcqPSGmmWlCVJeV/RcicpFGnz5ziRquzOySDaeenk/yznA5+AMQCkuzuVT3aVJEdUuYDk618SCjJy5rRvVsc5vMi52KD2hf/Y5orV+sGh34XwLaywO3ZNaTkzhr3lOjjoM8YfsQL9KKrZIbPbdEE1JxsLgb43zDcvhlCHB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBI0x3R5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBI0x3R5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34CB1F000E9;
	Thu, 25 Jun 2026 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782373616;
	bh=B6QAxfd8ObnoISPx1DJ0sWO4R53SNVzLZ8T4TIfZghM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QBI0x3R5jhENBc6KNfl6qZWqGpeI/KXkCoHXV0+Ypaz0xvMKYzcTpkGPlMVR874ea
	 z+RWmEHSHUVoCTkkq/RaOptVDJ87/9KjtGMUM8ZfmWizqfWEYpAcsKeqj+/bn0Etak
	 lat48+7or1aDYbcT7uT/LSdE+Ri7IdPnmR6hFMM9yo+87Yl6Ly8zNXbh6KOdA1QDv0
	 7XF6/AbD8+B0A3U2ZRk2PeMwdRBf1BHaAZ+ZYVtUJ24Lm6uMULqhDXeGkMxXD5soxF
	 XRho+8L2PkaFswS/DBiR2T46X6pbe0wFQgSVs73c/0TfMfEm6koo/DnsqxLoEYgwAR
	 hEn4PE57Q7lpw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] iomap: add helper to keep uptodate bitmap in
 sync
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, willy@infradead.org, hch@lst.de, djwong@kernel.org, 
 miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev
In-Reply-To: <20260624212925.1668662-1-joannelkoong@gmail.com>
References: <20260624212925.1668662-1-joannelkoong@gmail.com>
Date: Thu, 25 Jun 2026 09:46:51 +0200
Message-Id: <20260625-zeilen-allein-beimessen-2f631e840538@brauner>
X-Mailer: b4 0.16-dev-d9d01
X-Developer-Signature: v=1; a=openpgp-sha256; l=382; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7Ko7l5j62juXmtEEmF88xJJP/vihMyfnZ2pdrPKmOyA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTZ3HnXVJGp/06lsfJvl90VH7e1Ro+se8S6/q+7r/BX/
 urtq5fdO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSGcPI0Lz6Latfa2HtH5n1
 Nxdv/+a+Mjr11MOr+q8jvRUXmXDslGFk+LKLY27I/Q/7nPdz9vueTUty91waXjojaI/2erdig8d
 NnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> This series is on top of the main linux tree [1] because it depends on some
> fuse changes in Miklos's tree that were merged into 7.2 but not yet pulled
> into Christian's vfs tree.

So I pushed out vfs-7.3.iomap based on current mainline. It'll be
rebased once -rc1 is out ofc but so you've got something to base things
one.

-- 
Christian Brauner <brauner@kernel.org>
