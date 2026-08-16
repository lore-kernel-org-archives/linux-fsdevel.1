Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BC3CC7CC
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Aug 2026 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909205; cv=none; b=tJmzM2dX3p+rsCnbU5HlBwvri+kp/B0hdF9SqEFqomoNREVWWi1MixcFPsXFwnAui2SNDWZDB6By1O3exBMdtfcuJ1OvZ8grXBa/gIGdKs4fOCV4DVth5jF5eUc6czsrFMDwbKbqRYkugoHdyp76YSgY7wa81SomnEFO+tv1TaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909205; c=relaxed/simple;
	bh=nnRX6cRKee4h9GIK0oORHJKfN1pNQMugt1gX033rQYc=;
	h=To:cc:From:Subject:Date:Message-ID; b=UR1Zi04+XcmyAZnvNyzAnAH7ILab8iO4MrFXORoZH5f5w3glIkczIx4eeSwT41ZfAZes3GsTBnPvZj2oR+qNMOs3e4iKZT7gpZd/HUuxooi0M4qPn5nvBs8gYiwDTtxOYcrkl6I1ZZhs/qnuuP+4p1GGW7Pc6o8Y/XAdS94MMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=Pb1Spnrq; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="Pb1Spnrq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7wcfkTKq6uwadqzYMKduj6FU+uY4hjjrru0y8vo0mkU=; t=1786909203; x=1787773203; 
	b=Pb1Spnrq599JsomoJa8KVXvpWfRK+Vm/7VwKBrYfYs5bxPJd26e3SH3DP8U18CjD6bmtxMkIt5i
	ZKinUx8kJAcmiDc6Gx4WnhWL6IC7S0kVo6CLNbgJUVPpVERuHadCeCUL02sbrdoKtpjWaVhZ6BU/t
	qWCXbFusJZNMWvw8B37v5wjeh9rsjkUJ5XS5do8huYL+g3WlDBrh6xDjK2TtnRFn0Qx7xXcPMGrhx
	rbVXYTH+4mudyVhAPoT0curoEKcNfoX5xY8QMZcM9yf7OpQNeBfGv1kg18rerTs3J5X8HGfLtG0Hn
	b4ZVsxQ5K0kl4TImxLF9nD19pmgV5T3wC0Ng==;
Received: from c-24-60-177-128.hsd1.ma.comcast.net ([24.60.177.128] helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1wvgBa-005mJu-S6;
	Sun, 16 Aug 2026 15:06:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id 4204C3BC6EF8;
	Sun, 16 Aug 2026 15:06:22 -0400 (EDT)
To: Namjae Jeon <linkinjeon@kernel.org>,
    Hyunchul Lee <hyc.lee@gmail.com>
cc: linux-fsdevel@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: red zone violation in ntfs_runlists_merge()
Date: Sun, 16 Aug 2026 15:06:22 -0400
Message-ID: <9519.1786907182@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The following mounts a corrupt NTFS image that produces a red zone
violation:

# uname -a
Linux xxx 7.2.0-rc7-00016-g3d6d817622b0 #40 SMP PREEMPT_DYNAMIC Wed Aug 12 13:01:40 EDT 2026 x86_64 x86_64 x86_64 GNU/Linux
# wget http://www.rtmrtm.org/rtm/ntfs2b.img.gz
# gunzip ntfs2b.img.gz
mount -t ntfs -o loop ntfs2b.img /mnt
[Right Redzone overwritten] 0xffff888100321300-0xffff888100321307 @offset=4864. 
...

The overrun occurs in the last three lines of this code in
ntfs_runlists_merge():

                        drl[ds].length = marker_vcn - drl[ds].vcn;
                        /* Finally add the ENOENT terminator. */
                        ds++;
                        if (!slots) {
                                drl = ntfs_rl_realloc_nofail(drl, ds, ds + 1);
                                rtm_check(drl);
                                *new_rl_count += 1;
                        }
                        drl[ds].vcn = marker_vcn;
                        drl[ds].lcn = LCN_ENOENT;
                        drl[ds].length = (s64)0;

After the ds++, ds is too large, but slots == 1.

Robert Morris
rtm@mit.edu

