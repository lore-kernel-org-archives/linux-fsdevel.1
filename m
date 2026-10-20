Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.162.73.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792533155;
	b=jN/0FQjjw9cpRuflNXPQ7yCE3AhJgKafBFD5mzmbrr2/F3sCATeX1fy7tigxf2gc7lgI
	 uwcG2+jEKNApG/mal8LEzrxCrc7zAWoQOC49yBWN6nhwW06OOdooznMfI3ex3duUjKfia
	 FtLN2MSvMxYGzESkNapvTlg4teaOsnOkPMsmmtfqCBL0q0zkXhNydigWT6u0Eso3xFq2w
	 1DfT987SPiUf1S48v1NtBern5JqjWzWf3pL4+sFXxcwXfyRCveKteJL5pgVMzxqMvAjqy
	 uy34JiGsbJhc5LAklr3nOUE2HGaTHz0cuIygzmAu09TkucdaRI4G0oX9qYzCg7Arnvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533155;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=VJm44DGgOC5xDuMHC8w1pzd7B6Ver7ipXPOgtznarBc=;
	b=ZwjeOocxaZDChV0jaPjGf/3ecC7zeb8Y6W6dFR50O8GVvzWzCzy2d8QZpGpCEP/ofwCj
	 PrbXaCw4oLUmZD93au3CiftC13dEQhMwyyquhZSrssz6ufMZhFuhfNi/pWSNz9/G99l52
	 JJWQUp1MilkCEqZiR2g6H5SkhSzMUygRLZF0+qDI7hiVMCJ4ctrKhTev5QFyQHSGSK0ZP
	 EYrRQ+QZDCoK3Rw6V23lhQ+AZ22HEwk0d7JDi2dG2FjKVkWZuUs1yjzs84x+mKqKnW5fn
	 HnmWalFxhzBCwX/VVyEYRysJr9ffvXFADNnZW4lw0F0rdhovqf+97FeoohLs9CXgCrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qNCCfzH4;
	arc=none smtp.remote-ip=35.162.73.231
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022B606A321;
	Tue, 20 Oct 2026 21:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D022B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=qNCCfzH4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1792533154; x=1824069154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJm44DGgOC5xDuMHC8w1pzd7B6Ver7ipXPOgtznarBc=;
  b=qNCCfzH4wYnPd5MrRHA1GXQs5C1LDzOp7dHvuB6yM6WICUujiI1FqQ9i
   gFo2RgsxwOfwTlILcN6vmmGZSAR2Jn3Q6kINbzstmisbI31P/aW+D0ZgM
   N7N/FJc3hKODuIFbpL6QAI4GWd628wYR05BQNMjKzClXXvroszeD3QauX
   P3cGw4AA+g5+NVhi0qYGMD+6Nb7eRaRL+zOgdKNyG3UpEc4BPLkj2WoSQ
   eSJ+t4HT3auSNHnZ5MQUPxyd62oUUEUFfX45hX3C7Kb7DtUM7loQ3F1k2
   84xP2D/6osYK9KM1U5/WQ9rLwTxZjoDATpTDgNiH/cEXbZ5Eg8tomEoDC
   Q==;
X-CSE-ConnectionGUID: cD6Y3KDCSD23rWAQHjicug==
X-CSE-MsgGUID: pXYURbvJQdaHH+kDoOMELQ==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31601609"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 21:52:34 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:31492]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.1:2525] with esmtp (Farcaster)
 id 27c2f569-8c9a-4699-91a9-aee12897a8dd; Tue, 20 Oct 2026 21:52:34 +0000 (UTC)
X-Farcaster-Flow-ID: 27c2f569-8c9a-4699-91a9-aee12897a8dd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 21:52:34 +0000
Received: from dev-dsk-youyouyu-2c-7ec217cf.us-west-2.amazon.com
 (10.189.234.25) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Tue, 20 Oct 2026
 21:52:33 +0000
From: YouYou Yu <youyouyu@amazon.com>
To: <jack@suse.cz>
CC: <brauner@kernel.org>, <dgj@amazon.com>, <gunnarku@amazon.com>,
	<lichliu@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<youyouyu@amazon.com>
Subject: Re: [PATCH] quota: initialize dquot cache before mounting rootfs
Date: Tue, 20 Oct 2026 21:52:29 +0000
Message-ID: <20261020215229.31406-1-youyouyu@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4x3ngu2v723xnbommkln6yjwj27qdiy53dphxp74thsbihfqcr@rehvrhj7egvk>
References: <4x3ngu2v723xnbommkln6yjwj27qdiy53dphxp74thsbihfqcr@rehvrhj7egvk>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Jan,

Thanks for reviewing.

On Mon, 19 Oct 2026 12:44:49 +0200, Jan Kara wrote:
> I definitely don't think anybody sane wants quotas on initramfs. Is this
> just a fuzzing result or are you really interested in that functionality?

The truth is it's not a fuzzing result, we are really interested in it.
We run systems that extensively use rootfs and we want to limit per user
usage on it the same way tmpfs quotas allow on any other tmpfs mount.

> Instead of pulling quota into early boot I'd just refuse tmpfs mount in
> this case (same result as original behavior but clearer error message :)).

Refusing the mount would avoid the crash, but rootfs would then be
the only tmpfs instance where quotas can't be used, even though
initramfs_options= exists to pass mount options to it. That said, if
initializing this earlier is a concern, I'm happy to rework the patch
if you have a preferred approach.

Thanks,
YouYou
