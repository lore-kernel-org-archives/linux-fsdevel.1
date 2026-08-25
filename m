Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545C44163B;
	Tue, 25 Aug 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662386; cv=pass; b=OlYTi/0XZhB0CatuWaZJ7DGzoilrwApaee2aEOuDsa9jcy7PZNdM3i/aad3I+gN76PmRCYbPfRb+XNndRLR2JFvBP+U1g/pxsTXMtJeslo2RVcLc2VtbFY/XGHmEy+WM9oWMA7sygz9pgGTlM/smx+lPw5yuiMZRuOaMIALzZIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662386; c=relaxed/simple;
	bh=SzYCWhCe5IG9UaO9NPDzzx5saR+U/Zt4mKgeP989cYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1/ECPmvG+ZeJ76bxuBxRF9T626JNlgnqE//dJkwnmh2xiOus3S5ud0bNvznVDrxKPzfaoPnrQkTiIVgOp79T/s0Sw2o70dXCUPkoRVfbiWCwjhWOHefq8PeYVx1DKh60CdzfD7I+uk2Rtch34pt8hZJRMWRK7xxmCehsv0snww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=fmfSfLJW; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="fmfSfLJW"
ARC-Seal: i=1; a=rsa-sha256; t=1787662339; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iYUaNZj1d0o72sF04ODOjUlqfSIDNEtiBVyuY+ZJBdIXayHEg0cgDvVQ6Z7DfFuhcK98IFxXS2n1UVU6geZkDRDMi13oUHZyt6y9fXAyeXeFjo2Tw1G3CnYByBNhcRD/SC73nRIXjNXOdyW0GHcvg74UOF10dHNfAt6iIyIktsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1787662339; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SzYCWhCe5IG9UaO9NPDzzx5saR+U/Zt4mKgeP989cYA=; 
	b=TfsaCzujjUrcKeHEgkcexGYWWvzYKDD4w0Wo6KuJPtBlla0n4SBJ+KjLHgiZ05Las5m84KuuwRl6raKswGa39e19OPLJdz7bFJiEyo0waIppmgtl74oYp8w3NljdC5b4JiEE5QtBf9/FpNgdKLYnJmROEchrvp7H5ZSRFprLGwQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787662339;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SzYCWhCe5IG9UaO9NPDzzx5saR+U/Zt4mKgeP989cYA=;
	b=fmfSfLJWFe9eDmOBxYko/0/A0qdszgsQ0bAIAs9GewgR9lXqmUc5ojKA+ONHPPLi
	SJJzSng0iBfBvGaBve+q+EGayuwtWMqZMJnwYn46ILSDmuTbfvng/77kD1ArAKl7uM0
	2g8CAcaEzR2yDkjW15JBbWJQvGuSGA4L8copKj1I=
Received: by mx.zoho.eu with SMTPS id 1787662336844661.3855417014223;
	Tue, 25 Aug 2026 14:52:16 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ufs: harden the mount path against malformed images
Date: Tue, 25 Aug 2026 12:50:44 +0000
Message-ID: <20260825125207.1745021-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-andocken-beglichen-taktieren-fb2e887d14cc@brauner>
References: <20260825-andocken-beglichen-taktieren-fb2e887d14cc@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On Tue, 25 Aug 2026, Christian Brauner wrote:
> In the future, please cut down and rewrite LLM generated cover letters and
> commit messages.

Thanks for applying these. I wrote them myself (English isn't my first language, so I guess that can make them sound a bit artificial) but I'll keep the
commit messages and cover letters shorter next time.
