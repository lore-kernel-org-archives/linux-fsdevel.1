Received: from arkamax.eu (128-116-240-228.dyn.eolo.it [128.116.240.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4898E42189F
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.116.240.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601081; cv=none; b=Z6n58B+bvXp2yJGPcCUPd29WduwYBdIQCZOUp936NgY/gR7wi4+SSbJ58IVE35JlOpn/EefuS0NIRomfsZEo4j+UYFAzImGv0a9c13FDf3VLcaEswcwyLCNvvsvBs2tWwiOLTRFGQC4FT7U4L4hqw8nKYNQkfZ36dLR6Wjn6Ueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601081; c=relaxed/simple;
	bh=ocDPj1kcf3YrV5ATMrHOQMx5TUbcUx3qP3WFu5fA9bc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qTrSBrk4CmMS3FGbgEkbvH/z8H9Iz4OpSHxfDGf6gnKhdUq/KffKlITMh4PQEQvqNlSY6L1bGGD6nKCRmFXi5DT4fgLJAKDcjwBckVzYpYm1OKtF142i2oqdcki6UYTW2NkwxYZ6U+zvClAt5sqOdJ0LvvKHZTq+d6+v24OQ0ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu; spf=pass smtp.mailfrom=arkamax.eu; dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.b=HXKnt0Jl; arc=none smtp.client-ip=128.116.240.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamax.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.b="HXKnt0Jl"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=ocDPj1kcf3YrV5
	ATMrHOQMx5TUbcUx3qP3WFu5fA9bc=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=HXKnt0JlzGd2Zivhsk1PlnyDGhsX+w7Ty+/bZ
	VrpRa7jm7Hg58Kog6Kn/cUEQhgPeWs+fIQB5u7IX5ykTrFLOFvB5BKXWv9jteaVOfPtzqL
	TJ+3gBbJ0H7tRJYFXbevldbSY9ryFqUYeQIV5jBFAfX5gUzE24PyFaAMei4AXO1JSCVtFT
	fzmyQVOj5dOlH3+7+xe4Zmumshc9p4DMzPhEjacFT5Ly3yNlxb5yo1Rotgp1xWNkbJ7E98
	6+mGcbDv3TVs0pP1toBy+yToA8TukUqJfWJP6qHHfaQ8HlzpzuYwsKybMCZPyxlleb50Dx
	LsIX2ivs8Kht48pGEBP1ahlFQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 3a45603a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 11:11:09 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 11:11:09 +0200
Message-Id: <DJACVCF5YTMZ.3TWM3MQYJCMA@arkamax.eu>
Cc: "Jan Kara" <jack@suse.cz>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 8/8] nvmet: make configfs setup namespace aware
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@kernel.org>, "Christian Brauner"
 <brauner@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-9-hare@kernel.org>
In-Reply-To: <20260613111437.101763-9-hare@kernel.org>

On Sat Jun 13, 2026 at 1:14 PM CEST, Hannes Reinecke wrote:
> Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
> nvmet configfs namespace aware.
>
> +static int nvmet_add_port_list(u64 ns_id, struct nvmet_port *p)
> +{
> +	struct list_head *port_list;
> +
> +	mutex_lock(&nvmet_ports_mutex);
> +	port_list =3D idr_find(&nvmet_ports_idr, ns_id);
> +	if (!port_list) {
> +		int err;
> +
> +		port_list =3D kzalloc_obj(*port_list);
> +		if (!port_list)
> +			return -ENOMEM;
> +		INIT_LIST_HEAD(port_list);
> +		err =3D idr_alloc(&nvmet_ports_idr, port_list,
> +				ns_id, ns_id + 1, GFP_KERNEL);
> +		if (err < 0) {
> +			kfree(port_list);
> +			return err;
> +		}
> +		WARN_ON(err !=3D ns_id);
> +	}
> +	list_add(&p->global_entry, port_list);
> +	mutex_unlock(&nvmet_ports_mutex);
> +	return 0;
> +}

Just a minor thing that I noticed: the error paths leave the mutex
locked.

Maurizio

