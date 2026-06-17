Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE92E736D
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695078; cv=none; b=ssXcQF434IDn4/kmchP23tBsHj4FtTx1pBtrnyIiFG+t4MvTzka2xHLcyZU+OgeUaWJdWycMu4OC6awfD54m72Wsd4Jint5n9RgOo+G8M54CMcbuZ9kaxWVUUsQXkrXCuPlzzi9a/aIafg9m2IUjy87Yniup4DaAIVWl/JIA+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695078; c=relaxed/simple;
	bh=KMVSoalCvC4SccroEeCkdoSu9bL7LKsGd+PSlM5TeC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIpbUC2N+H+l+FgPYMKbm/AuZ+WZ2yghhLQOMI+QO/pSm1tf3cxtlN8dG37c8ZIs6bp0Zk22rtPc//qrTveMxvuliN6XJhvMk3EtzrdUaoxz8vEdLMGUch9D5k0o1/iinuh6sHQBvyQtgH5lC89wXncknuZ8yWYI/T/GEYN3sow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr2ubg8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr2ubg8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6411F00A3A;
	Wed, 17 Jun 2026 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695076;
	bh=cbiNe1YnAqB3ZwgAA1UIZ6qFlamXDIo6ltboGjoQYgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hr2ubg8bKaBpPw/SK07W5fKBRUWFdPUe24ZYhduhWnHbPHHzdkbnj7cdQkqsZvyTo
	 EtRq2khN0nlPzSwqoJILt7ZxP2k7xzAB4hT6oHMse7Ydcez86K6h6fxYf/M+nbtzQI
	 s4ubPoNs4dfpBqsbx0eSmbhFmFo8hd3EJd1qe3/hsKHy/8p1+2Im+S+CUrZiBKgViV
	 PnocQw2LWYp7dyZM6X1wFJvK/RrBNe6kCNbuRcKgYlx0iOW+MnePknZyWicN/Lvj6h
	 gcaERT3hQnJLyZRRHiM/mqYzWMeSTpHl0s6KU3Xc/5tUmSZbBtFEVPF+QkK8AKgUol
	 4NTzXTh7y8pJQ==
Date: Wed, 17 Jun 2026 13:17:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Andreas Hindborg <a.hindborg@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/8] nvmet: make configfs setup namespace aware
Message-ID: <20260617-kaufpreis-zugang-raven-4b0129e8462f@brauner>
References: <20260613111437.101763-1-hare@kernel.org>
 <20260613111437.101763-9-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613111437.101763-9-hare@kernel.org>

On Sat, Jun 13, 2026 at 01:14:37PM +0200, Hannes Reinecke wrote:
> Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
> nvmet configfs namespace aware.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---

What tree is this all based on? I can't apply it at all which makes this
kind of change rather difficult to review meaningfully..
