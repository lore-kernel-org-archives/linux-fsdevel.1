Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B2E2C11DF;
	Sat, 15 Aug 2026 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809886; cv=none; b=rBnZshekJFa9NuKNeofSs3hK8MxoQhd2/c3J0hEp9yb5RTUpyXIr/qHHTeqm5VSok86Wn2Fj+YQbAPurLwePqkAk/o0JFUbGJMpxptyV0RK8cHzbVP253ITugZ0Bkgp++L5JmudpAYsqdGlUFntwgxg1PcNL1H+AqlnviVNbUX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809886; c=relaxed/simple;
	bh=Ua8mFtf8zB2pwtSS5pdnlpxstzJMX9SfJcWg7kSeSCI=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=tpyAj9ootMC/c+NjB0B/9WQMgoDI3q5saDQDT5TouXPlw5NS6hW+lt1eTNfHZsDZy6Kta1jJZ2vl68/TZPJMS6isCmJ1b8PeqFJ4QXWl5K3PwBadxbOVFKcFa10MZR4K6eNP8EYA0nl8Wdnp3QniDjeg7dDIH3eK9VL9uKV2xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=nx8sBAmP; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="nx8sBAmP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786809874;
	bh=Ua8mFtf8zB2pwtSS5pdnlpxstzJMX9SfJcWg7kSeSCI=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=nx8sBAmP3RxA/S+NfyjIysvZsUkNejCYLu2uASJxaavpSwhLWBsnPfBOB5mFI+2we
	 6WNq0EgGMoJpMGxn+d1F39984zhZ57eVyg5u8tY0DUki0+GzaIc9+6z44Wvt3wZolO
	 Z71V7gUjnIEwKoJNRDvqGENDxePuE+KVg5O7VNhY=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hMkSL2RQzz10rF;
	Sat, 15 Aug 2026 16:04:34 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hMkSK5zMvz10qy;
	Sat, 15 Aug 2026 16:04:33 +0000 (UTC)
Date: Sat, 15 Aug 2026 17:04:32 +0100
From: Bradley Morgan <include@grrlz.net>
To: joel.granados@kernel.org
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/4=5D_sysctl=3A_Split_data?=
 =?US-ASCII?Q?_conversion_and_file_position_handling?=
In-Reply-To: <20260814-lklm-partial_ctlvec-v2-1-9df50d26e477@kernel.org>
Message-ID: <D5FE866D-5393-4E51-8302-E6236B0D059A@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

>Rename function to prov_vec (from do_proc_vec).

s/prov_vec/proc_vec/, the diff renames it to proc_vec.

Also the SIZE_MAX comment in proc_vec() only talks about the no
parsed element case, but after 3/4 a kmemdup failure leaves
left_nbyte unset too (it goes to out before buf_left_final gets
written). So the sentinel covers -ENOMEM as well, a line saying so
would help.

The split itself is fine, so with the typo fixed:

Reviewed-by: Bradley Morgan <include@grrlz.net>
Thanks!
