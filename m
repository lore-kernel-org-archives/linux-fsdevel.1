Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B22369997
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187713; cv=none; b=hS+jdHQbQOY5pZlQmSmTnWJXRJhWzOaFqoG8Nw92+Ab8P8P74RvN+IiMsoCErm0yaT2xHohP695wqteeVyEavUa6pzAv0CXxwJJrMVovA6ti+dh0dY8epKvAsffGdU1OvpyXkberFoGa6SVx2izRb3oOJljFn0Mara35GNEY0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187713; c=relaxed/simple;
	bh=B9Mv3cTVdLBFcmdbVVEclptEUG046aP1KVOtOLYX3KQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=E4l2jMdJEOhNT570tMUQ2M0R8WyzRS1NXoteU138N5Tj21QP5E+CKDCgpTjS48vPkjwewRkH2Gqcs70sG5gaGHnduXPMkrnk0jXi+7cK8+N+L6vlEjRJNuseSI57B3CLJm+I3WO+eh8oHQiChGetfXDZE5EvN/2dRMeTiwGvSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INiUr4eo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INiUr4eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B660C1F000C5;
	Fri, 16 Oct 2026 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187712;
	bh=/+gvRFCpRyy/4Z3arrtpADgY82o65vcz2kOTGv1bsR8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=INiUr4eoIvVVRSx7M+J4Qk6em+HraNHZrC+asbtB25tPvAUFK0Hedg7qArqGbctIi
	 D/tUXT7AHz9S1lcPIb5sQOTg5fqq7V19R3YJAoTwyEov0bke11Rf7/zv2If59HZ3qo
	 oSVXXdjcQ2ET0MzRRW5DSSnN+J50fOLld3PIYwErv4qVnxEjAmikDgmAfeo4SRXIg7
	 CG29x3wfHooBSFEN4DM5ho4rbA92pljkXG/R/nqpbeDv1VQ2PNq7+zxqIRTbjSO7bO
	 7UU6hKmxUS3/xEByD2/RO1YUk1f4smHvD5udOzLCzIebuWlzelHa/iaVa4AgG8c/6+
	 dpqT2AK8Pc3bw==
Date: Fri, 16 Oct 2026 11:55:12 -1000
Message-ID: <5c162c3f2de5753d4c95292b1311c3a9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, akpm@linux-foundation.org, roman.gushchin@linux.dev, dennis@kernel.org
Subject: Re: [PATCH 2/2] writeback: clear old wb dirty state after inode switches
In-Reply-To: <20261016115230.3640770-3-sunjunchao@bytedance.com>
References: <20261016115230.3640770-1-sunjunchao@bytedance.com> <20261016115230.3640770-3-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Hello, Julian.

On Fri, Oct 16, 2026 at 07:52:30PM +0800, Julian Sun wrote:
> Call wb_io_lists_depopulated() on the old wb after the batch of inode
> switches, while its list_lock is still held. This clears the flag and
> removes the bandwidth contribution if its dirty-I/O lists are empty.

Liz posted the same fix as part of her series:

  https://lore.kernel.org/all/20261015-wb-dying-cgwb-flush-v7-1-9278d9ebaf5d@honeycomb.io/

Thanks.

-- 
tejun
