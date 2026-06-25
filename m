Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655625D53B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392551; cv=none; b=RFcP2a9FgQSuPLiwqCQW8BkVcioBe5onZo6WElj5WQo++cwP4I8f3mix2mBSF8FnM/WuTR3yGTTsw1IaHZAz2GEt+kixkAamVCXxwYDz5IIRrcl9MC5hk/y3+aTzqb/Flw5jBVtBvoMFPbeUGwLOqhZ/Y1nu9QzDAbceoJJutt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392551; c=relaxed/simple;
	bh=hr50eI0beySceQMd16J9KyCPUmik3+4R5AiGUHrmldM=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=O4IAGccQ58IPTglpvLRtWs/HIj5mvtnndr9x6hGjXGZT3d67CjfDAYQdFh1YkPIhlazBPVtB3aQuDGTjSdXaybSxVVWWThMsx35oqpFj3cT/HpjjZgflqjJa0SkyearzY2/PEJqSz6v4Ixa86rsZ5gDoxQ+gQm2Ofkqx/MUy2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=mew65xYs; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="mew65xYs"
X-KPN-MessageId: 1986c1a9-7096-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1986c1a9-7096-11f1-9e8e-005056999439;
	Thu, 25 Jun 2026 15:02:20 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 19846b44-7096-11f1-91a7-00505699891e;
	Thu, 25 Jun 2026 15:02:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=hr50eI0beySceQMd16J9KyCPUmik3+4R5AiGUHrmldM=;
	b=mew65xYsBgGrg6wpLRdhQtyWLiOonWHda48rZlBHpc5U2STZxq7cFupQScTyCETjNWW37G7ubeBko
	 ASJLNNtCYlLdnKx6DdGsJszsoaFi9YqemWE4KP6YFWPLHWo/+6FmtyvfY3P2NIQ+JEh6+8QaKyxooS
	 CoDGZvbFGa6X5ojZxo1TUZSvk8SCjYKEtA0ahWXUDM5ueIrWbPB0E13FeN2oewbsXfN9w32SnanmPS
	 zgkbi0bA51hNFsAM2w7lmK393lULe3teY8ekthLhAvgA1KXrOGmw2jiwzKhZCSxh4M33bEhvtek4iU
	 NfBpJdx15Fp6qR3mhPCcXX3lTggNuxw==
X-KPN-MID: 33|ePh7gmVBSt5qXbIaQfWGkeorGHcw12qJUg1oXacklqb2faSYQAIMNUnp+lWPg1f
 CFw3i+TFjLQMBgAZMHWr7EnWhzGuI2CeWFruaU++JR7U=
X-CMASSUN: 33|yNZWR9Iesf34M5UNey50riEEQEkVXFvSRzu1j+hAwVbTZm9/nUOiWAjVho71W03
 eGcK+oG1Zpxuezagqll4daw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 1972b932-7096-11f1-916a-005056995d6c;
	Thu, 25 Jun 2026 15:02:20 +0200 (CEST)
Date: Thu, 25 Jun 2026 15:02:19 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Message-ID: <716044027.2969861.1782392539951@kpc.webmail.kpnmail.nl>
Subject: [RFC] fanotify for flock release
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

Hi Jan and Amir, (cc Christian)

There has been a wish from systemd to be able to be notified on flock(2) releases.[1]
I've been looking at the locks.c code (I really wish requests were decoupled
from locks... :) ) and the fanotify code, and this seems to be a rather
straightforward expansion of existing fanotify functionality. Before sending a
patch up, are there any objections to this? If we implement this should we
also do POSIX locks notifications? And what about lock taking?

Best,
Jori.

[1]: https://systemd.io/BLOCK_DEVICE_LOCKING/
