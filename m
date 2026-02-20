Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5CB33FE07
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585654; cv=none; b=uFQ4hd8QQG/ieCgzA+g4cGlBgrP6Md7jfCvShuAurSZQLflD9Z5OAKA0Jfe7ZnDKj8e8iZAbT8l/3NaKih9AAbQFDxT07lWPpzO+QStBYdLD/SpKl7OeUqST+xLSlUAWA0iTtuQgxf2hslcz/mWyW41xSF9tai380U9Di+jwArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585654; c=relaxed/simple;
	bh=UQU4Sm4+MRCM7WUhVKvPsVJtc6YFynAtHm4uL+pJ4uE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type:
	 References; b=XHqrE/t/m7h1lYYqKlRSPl401naCoNllA62qj82kNBG52TLcQ+6216kM9Itwdjbh/p+u8fFQbyChPSN+PHEi+y2cpbQPZl7BOW2ve33IyUWElbh9aEFoJqEvp2LB44stkTJEkmuWwVPrG87c4/1XqzcNQ+PnjJTF+m5RJ8npLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Fkn1LQc+; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fkn1LQc+"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260220110728epoutp01186eb2c9360dbe71404557ad6a749ed9~V78LsMHEB2293622936epoutp013
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 11:07:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260220110728epoutp01186eb2c9360dbe71404557ad6a749ed9~V78LsMHEB2293622936epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771585648;
	bh=gOA7TXNnk4U1tQPh3I0wYA2LWJ+63MELxbO9+K5eB2s=;
	h=Date:From:Subject:To:Cc:References:From;
	b=Fkn1LQc+LjCion8OP4r+g5HsPARZD+A5h5PPaAQYP+gzsxpQBG59SPipU9TXeF0Yo
	 3CM6U0fht/8vf3q1d2eXFS39Hwh7hmOKNNFDxi2kytMz/horIaWsTQZZolyVfY2sLm
	 97gSqs9CK63vmnpIQsIj09yGZZMF8+hQKRdzmcb8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260220110727epcas5p1b286e9e6da777751fbe5ac4807d9cfab~V78KdpJum1962219622epcas5p1R;
	Fri, 20 Feb 2026 11:07:27 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fHSBk4fzvz6B9mB; Fri, 20 Feb
	2026 11:07:26 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260220110725epcas5p41a6ae8751fee9782f338cbd66dd2700d~V78IU5gZv1047110471epcas5p4i;
	Fri, 20 Feb 2026 11:07:25 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260220110723epsmtip1603367a8adf3229ea5a3cad4d21db624~V78HFRgd40255602556epsmtip1G;
	Fri, 20 Feb 2026 11:07:23 +0000 (GMT)
Message-ID: <83f2e586-75d8-44a3-8427-ea6165f1dff9@samsung.com>
Date: Fri, 20 Feb 2026 16:37:23 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
Subject: [LSF/MM/BPF TOPIC] FDP file I/O via write-streams
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
	jack@suse.cz, amir73il@gmail.com
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260220110725epcas5p41a6ae8751fee9782f338cbd66dd2700d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260220110725epcas5p41a6ae8751fee9782f338cbd66dd2700d
References: <CGME20260220110725epcas5p41a6ae8751fee9782f338cbd66dd2700d@epcas5p4.samsung.com>

I have been unsure whether to propose this, hence the last-minute 
submission.
We discussed the topic over patchsets and at the last LSFMM [1].
The block IO support along with the new construct 'write-stream'
(distinct from the existing write-hint) landed after that.

As a quick refresher: while Linux supports write-stream based
placement for the block IO path (since 6.16), the capability remains
inaccessible to standard file-based applications.
For file IO support, I posted an RFC [2] with a new fcntl-based 
'write-stream' user-interface last year.

The feedback was to streamline the kernel-internal plumbing, and the
new patches [3] are aligned with that direction.

To summarize, the current patches contain two parts:
- A new stream-management interface at the VFS layer
- XFS support for this interface
The motivation, design, and implementation choices are detailed in the 
cover letter.

I am yet to get feedback on the XFS portion, but the VFS part seems fine 
following a shift from an fcntl-based interface to an ioctl-based one.

Since we have iterated through multiple schemes to arrive at the current 
one, I believe the most thorny issues have been resolved.
And simpler things can just get ironed out as I refine patches with the 
incoming feedback.
But a discussion will be useful if anything (heaven forbid) emerges that 
requires hashing things out in-person.

[1] https://lwn.net/Articles/1018642/
[2] 
https://lore.kernel.org/linux-fsdevel/20250729145135.12463-1-joshi.k@samsung.com/
[3] 
https://lore.kernel.org/linux-block/20260216052540.217920-1-joshi.k@samsung.com/
