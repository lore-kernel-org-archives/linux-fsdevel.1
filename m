Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152D20468E
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268367; cv=none; b=Ze/LR9VSDS0jgdodrGumrZ43drGMxxcxXgu0ySAdnHX/qAp+DYGza1Oc2hUHbLgSgxCAYY0xBvFIQnJ6dRoUX+ThAbGV7olTR/V6emM9AtdfobJFc3IyW8pB1maTyTfPc7i4XqiM7ZTMRhhRvD9W6bE9JeZlin9AWZN+gieKKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268367; c=relaxed/simple;
	bh=bz+wxnrPwY6gQR/fnC239269jzpPj2AZwJAfaJxaoOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Np+7rWgAMyYUUq83YyQkuMOU6f88eH7i1wkBzHpNmvsO7DHykQQl91Ct0J8CzHTi7RVm1bVOYHU2v4uQ9k3sh31CkHVIdKe+cQBYF/sqrAuoeb8jvFHrpYiJBQ7+tGOJJ9q2MR780nqTBPksCV2lvxjt5M/SnKEFgYZ2c612ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b=B92RAuEf; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dev.snart.me header.i=@dev.snart.me header.b="B92RAuEf"
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 016FB1D49A;
	Sat, 28 Feb 2026 08:45:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 016FB1D49A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dev.snart.me; s=00;
	t=1772268357; bh=bz+wxnrPwY6gQR/fnC239269jzpPj2AZwJAfaJxaoOI=;
	h=From:To:Cc:Subject:Date:From;
	b=B92RAuEfMBWL82IVyrufWiI/pSYepIHHjG6yjzIYS+cxfW8wj08hzaxDAFtaWlrSy
	 ivipONEYC1Kpb4InaWC81iAABSckDiX+D4+A121vkhfPHoOvugxC09KH96g1v3PFDh
	 a5H/uqYtilIXMZPh943cdduFv9FkP//Q+6HmqNFc=
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id jUCCJ0SrommvyQUA8KYfjw
	(envelope-from <dxdt@dev.snart.me>); Sat, 28 Feb 2026 08:45:56 +0000
From: David Timber <dxdt@dev.snart.me>
To: linux-fsdevel@vger.kernel.org
Cc: David Timber <dxdt@dev.snart.me>
Subject: [PATCH v1 0/1] exfat: add fallocate mode 0 support
Date: Sat, 28 Feb 2026 17:44:13 +0900
Message-ID: <20260228084542.485615-1-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed KEEP_SIZE discussed. Note that this only mirrors what had been
possible with ftruncate() previsouly.

David Timber (1):
  exfat: add fallocate mode 0 support

 fs/exfat/file.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

-- 
2.53.0.1.ga224b40d3f.dirty

