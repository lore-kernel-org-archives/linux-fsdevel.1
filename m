Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F303C2773;
	Wed, 18 Mar 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846071; cv=none; b=lMdB9s0RK+/8XUZzvJpvyPIDHYDOtJmJIXRiujg+684M3/nDh63/L+f6jCrIsUZC6eAYPj67LXpCb0Qmnw65qJpJaBn3lq4XGOO8kZrm6U5gWpryvJXeCLx7/TxTzcqJYWcHA5bOMPNAzd8yGUAD//guLCnjm5Qkn+rvGS6PG2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846071; c=relaxed/simple;
	bh=P4YEa+K9c9jqQdLeBR1cIjpkqHZGtordx422g2cxTmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ekysq3QXo8PTp9lcEbZGS7zer7PLBOGgSAiIcrF6Uxs6anVaSD9q+qn5Y1B7NC9n512/HNS1eiQaZXC9QDN3jZKApjcfS4M4yGteHp2ef0IvOmJh0CS0YOV45q7iV6EiiFVMEwyjowE1s1TOJmJtNh4uka+lxBXNdxU6n8W2yXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fO3Ze1Su; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fO3Ze1Su"
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 376f0427e;
	Wed, 18 Mar 2026 23:00:56 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: [PATCH v2 0/2] hfsplus: fix lock leak and refactor hidden dir search
Date: Wed, 18 Mar 2026 23:00:44 +0800
Message-Id: <20260318150046.431428-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d0176ce5003a1kunm8a6a5dd1194441
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx9KVkkdGB1OS0NMTkoZGVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=fO3Ze1Sub2FYjLbcR/ffZX5DYdevgD6DZy31jtrnaIKPkV1NlqdbS2pzOfcx1JpvI64kG/PlN8rWtlKwREMO7VFReNQK4mSPCb9dz0X3VYQX6AsptnAPGEK1qEHCQb8RKG+w8LDQNUZFOG6S4sSnIXDSgOMbSeqS86Z20oJg1SA=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=QPiWnRHRM37cRb6+3pnOEAX/JG3h1V6rAy/JTRFlL9g=;
	h=date:mime-version:subject:message-id:from;

This patch series improves the hidden directory lookup logic in
hfsplus_fill_super().

Patch 1 fixes a b-tree lock leak on the error path during the hidden
directory lookup.

Patch 2 subsequently refactors this lookup logic into a dedicated
helper function to properly encapsulate the data lifecycle, improve
readability, and simplify error handling.

Changes in v2:
- Add patch 2 to extract the hidden directory lookup logic into a helper 
  function.

Zilin Guan (2):
  hfsplus: fix held lock freed on hfsplus_fill_super()
  hfsplus: extract hidden directory search into a helper function

 fs/hfsplus/super.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

-- 
2.34.1

