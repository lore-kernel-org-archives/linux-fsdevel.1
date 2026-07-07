Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38612472A2;
	Tue,  7 Jul 2026 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395043; cv=none; b=Xu+1rHtI6s7P/qin6x0bm60LVVKtkaA+gtiqn7rLRbdFlTyu/pO/qvnFB+FJnlol0zqxY2r93AfhA9CklroqRlbU0ZrO5/opJnBPk0/r7jcIXHX6INyDWTo3YvbNdgFC8+jMkhV+fFD59uW94RN43OUkWWOvPlwQykWeTmQ5nTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395043; c=relaxed/simple;
	bh=65eWBW76n6xnTDAEVX1mX0bMCICpLCKgnSftt0Le7VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrUMyzpGCEo5GH5aMRaPq7UJeVs88iZqPqb/tgMPlsEirdzQUncWfqmH7Ijs9qfAPWiPp86RjRJoJS64CXQqcnAjNdFB7M9eVa2s7J7yoPUdRKVJN08owzLjcWm2kqWzqtEm+VBgtMimfWVh1/9Ut/NneATDbt5YOlucP7MJfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=eIX8ncNr; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="eIX8ncNr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+5
	m/UemJIU0WVqwjiIZfNMwHQhAxT0m+4XEKg0K3rIw=; b=eIX8ncNrHfGyVCnXO9
	fL/wfo7kam+d7FKkgVGRG6DtSRKCmArUARRs8vlRb84Jf65KZiGaqQWpuS7JZJFL
	j7sPVFGph8qopb/XIqSsh6MHfI2tGXnH87tAV7QkcavruEI3w2u5S9vbRm+8zcOz
	gSQlYEuDG+I7ieOEi01PbbVmo=
Received: from zhang.. (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPSA id Mc8vCgCHs8TKckxq0bQsAQ--.4589S4;
	Tue, 07 Jul 2026 11:30:20 +0800 (CST)
From: Ziran Zhang <zhangcoder@yeah.net>
To: Anders Larsen <al@alarsen.net>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziran Zhang <zhangcoder@yeah.net>
Subject: [Question] QNX4 write support?
Date: Tue,  7 Jul 2026 11:29:50 +0800
Message-ID: <20260707032950.3999-1-zhangcoder@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgCHs8TKckxq0bQsAQ--.4589S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: x2kd0wpfrgv2o61htxgoqh3/1tbiOQx9PmpMcszPGAAA35

Hi Anders,

I noticed the QNX4 filesystem in the Linux kernel is read-only. 
Just curious why write support is missing? 

Is it due to lack of documentation?

Thanks,
Ziran Zhang

