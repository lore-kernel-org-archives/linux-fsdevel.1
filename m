Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009218;
	b=49XZwZJAwWdyaUjznsl8+j58STCptXt4qSFKVyfQR0yHhPUIOhlMk7XcWqX/mwmkv17Y
	 hrSrR1VS5qf19tJlEBG5y8Kj1VexmxapXofTi1xOj3BIKN7t7OAsE82C6Oxyi2O1NSzCv
	 Qdg522KNFY0/tOLIZsX4Xy/nII/2V9VaPdM4onJ4zNczTMRFDPJMxacjcrwH38nqxyQT5
	 d/Stwwt7+kGt1uSF5NPKcPPhCPUPVG8RIxnVABcZyujjraUF8AyCtF2prnuE1iiDVoiAp
	 lBGhBJOAgxnBj05CaObUFumP/hcbQdu8eA2ViLUovNllRmvtdoBPo2r1X4P7bQMZpCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009218;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8kRkG7rwaQ8HsV3efBCaTcjLSOaMztnW8Cr6fnSooFk=;
	b=XV8fsESr6JNYkqg0q97kkPqW6K2cbdiXtUf9B2Tq5YdqXqZF3MTaQ+FXf7ikPsGWRxUb
	 6X32Aq5NFPqGM0AjTz8NRpsS7Nuvc4j13g1CTEi8+4X30UK1koBIpwp70cU8SeKKuApy3
	 P47Rv8W5fVZUS6MdAHuc9K5WAc9gk5NRefPnl7YHEUFtemhiiZiT7JSIIa4YEeDk5OlI/
	 eB+yIxXbcYiBeIS38mUV/hD5XsnNwO/WkFqAKCANzow/Fgm4Z2hlNFh8DgbIBDmkWET1O
	 25j6rVXelv9TJqe/4jY4KS8L2fjY0VnsrRDUrM2fykb5apbXiC/AhgNNQg2PKyNq1bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoSwZZ97;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CF0606A31C;
	Wed, 18 Nov 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoSwZZ97
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716001F000C7;
	Wed, 18 Nov 2026 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009218;
	bh=8kRkG7rwaQ8HsV3efBCaTcjLSOaMztnW8Cr6fnSooFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RoSwZZ97smTJZdBQCqxDPN2fRKZIozS+b0YQFjq7O5Av5n2PVdztrs/WyXbw/g2gY
	 B/s1hhXIju9/dCNxPEqUxpyK4atcrHn9aQbSESYLqTeyy5HcYPghp00XwIjlEL2FKM
	 ghgOFDdBFqWB93BAguq+noQNevjfiB+b2wkncbVMx1HmcgPQQtOc5h4BXMSyAHqxqS
	 6C7Ca3obyln0/wNaO2JkEiN1tv/oukTBsUXvHPVed/oCoaW0CXGxxsdjQAOsSRelch
	 z1SSMxgwwDgNJFPpp+ssUuUZOygLDH4erIp6S4KgF/CaRrDWzZTWC8lCPp2Zu4FMyx
	 5Tv/2OLJurmAw==
Date: Wed, 18 Nov 2026 14:40:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ufs: bound the cluster summary index in
 ufs_clusteracct()
Message-ID: <20261118-besungen-fingiert-festnageln-9233af206caa@brauner>
References: <patch-ufs-contigsumsize-20261118@qq.com>
 <tencent_ABAAD2B7E6C8BB138AE97AD4BF0F49145F06@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_ABAAD2B7E6C8BB138AE97AD4BF0F49145F06@qq.com>

On Wed, Nov 18, 2026 at 04:00:00PM +0800, Guikun Yang wrote:
> In a valid FFS layout the cluster summary array sits immediately
> before the cluster bitmap, so c_clustersumoff + 4*(i+1) must fit below
> c_clusteroff.  Check that invariant before the update and skip the
> accounting otherwise.

Meh. That's just pluggin the immediate hole. Two things:

(1) c_clusteroff comes straight from the cylinder group header as well.
    A large enough c_clusteroff passes your check and we still index
    past ubh->bh[]. And bailing out after ubh_setbit()/ubh_clrbit()
    leaves the bitmap and the summary out of sync.

(2) If c_nclusterblks < start forw goes negative. Then i passes your
    check while c_clustersumoff + (back << 2) still writes out of
    bounds. With back == 0 and forw == -2 you write at
    c_clustersumoff - 4.

Both reported by Sashiko.

Please validate this where it's read instead.
