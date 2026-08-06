Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3423B27C9
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035592; cv=none; b=aR4zB8MKLwpNjbxThL0yMOfZrkjECXnlOyEJeZBQCZpjirN/D63WTFJDC676RYvPx72vGYS9MruJt4mEUlv9ddN5j2E9PfdTmSnFfFvX7eSb9wu4xjMuBLGWOvzz6wR+9xisb1BvFET0p0v3yNGPucJsPpCSyggQR/pA5hOMhpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035592; c=relaxed/simple;
	bh=D13OR5xsYh8JEaA5aDJc/1Dh9iYDdCdoFjWLWDwwfds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTAUn01j+i2Ud3DgOIxixakF7ccssj2FMT7MMQwymT7ApZy2qoH0C8N9a1G2oU0SZW9r+i0yF1rL6r6ck0rqKHd3KXnEMWtcf1zFQjaYLyqa/kY5zY6Q7OAy6atRfPBcKgkqjE7vygAYceJWXSr6e16G98o9p54Xaq01z6gtQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JokYjx9r; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JokYjx9r"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5bf9466412fso1912366e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035589; x=1786640389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rb7ASnE8Sx91CLFoiOKNMQmqUcK+VC1xbbyNQo6vc/k=;
        b=JokYjx9rwzZFWo1aPiBFemi/KMNKkCeFR98eUzj2VARFxYoSgnSHz6lfHPqYFh3UPG
         xkU9PzoHD9JFlml5dt3QPAqdES2lOMfZaDCpOBUruI6n/G91+30AhmsFLXyVhYKKO0rt
         5fw3YwAQ87MiwX1ih0+i2crNk0Q2hYOZ/Jg5rTusgajx0KcgW/65Atrk+u84U+XndVD7
         mssxHvhLOOhAiqIPyqesfw/qGrGoV5Xki1sHTtVMC5pdHtn8C8KKm067gwz7MDcMcrE9
         ktNZoS9earIIfwKs51e3S1AI0RERs8WroyArPj8V0Ef2puUOeb4rveoqyoJ2fYd/LhP3
         C7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035589; x=1786640389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rb7ASnE8Sx91CLFoiOKNMQmqUcK+VC1xbbyNQo6vc/k=;
        b=Eyuz479nLhL9qo0zeRNElMdHKBEYZJX/BCUgqCUqB7KPC5yMzjuqfE6WEDyddUIn6O
         pe5hHWiOJjOqbkylD1iwvdqYCYdA3hcZ23NXybj4yi6V7NpOf6lKfGH1CTlfEDlJabTe
         zrgKji1huUBaWxUljH0fNFK7ytFmUVnPv6uk0C49eN6cujNbijQRWGYrhOJW0LmeO55G
         EI9l8OPgni3pSmbo8R28Ny3Gxoc1K+t3kRTFDESnrc/cpzXdmVE1uLkeEolD/0cFR+lD
         RVIE0B63z6ujCpNAhum7wxi3GP0WgkTh7Q2eWg0dxKnfeIXtVdqxSA1h3h44AzBtleog
         eQRg==
X-Forwarded-Encrypted: i=1; AHgh+RrmXU6B4C7G2YQldlJNqRhQ/vxWFWc4rSqx64rrCE1my18ozpy9+TkeFxgaxWzrld9PYYbDo9BIVYkfmQzk@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4AIOS7nTQ2mwD5KMH8UVDu1kbb19yvNTupGub3/V7hi8MH6u
	TPJbGY1J5W4MsH/DL2RVBVzuNpJF5GJVzb6icsAmClEnFCDl+s45b3Tn
X-Gm-Gg: AR+sD13u54ayJ3v0Gfqwa/00rIjF/mzrL1cdBrlU/hEL3n1CmiR2WDlcVk+e3SspxZ3
	RfV7aaT8nraylWxfV+lbcvWJFSEsA/qGgqp/i3AooPzl/SLFupAnPjrYxLaYk/YDPIZqb2sStdd
	TD846KK4cKRgOLekN4fTPjoEK/VuegjloVlAw7VHbLTHecA4awd6ubr4f20+oRnrOY9Zz2ut7an
	72jdeLNp0S42dqnI94BLG35E5P/TflZGlM3P4EpHc6SrMe6tKvEa6A3sIPcYUp6du9JpFSqZQ9f
	oZmVdGTqAeZesw72qXHv5ruCar19JHodr+pfCaIIN0XExAIq+PdKqZ8847pCI+GNdCaa/e2h1M5
	E56mF3LGHqyZK2KVJcZtCvG+sjxdVqdPFPgKM+zhkRBRGTlgrvOQXBb4VDqQRiYZbBlnl/Meq5y
	m2Utljxxx03ZSguJtmDEIlh1kNdLzkb43I9ssVi5RnQMZsRvQtVCMnMdvW02wEC16tOLtFZlkPS
	mTqwVQ=
X-Received: by 2002:a05:6123:2e6:b0:5c2:b8a4:95c9 with SMTP id 71dfb90a1353d-5c3d924e663mr477877e0c.11.1786035589499;
        Thu, 06 Aug 2026 09:59:49 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:48 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 11/21] exfat: check for a directory write error with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:34 -0400
Message-ID: <0784ef63a525434e7c0aff730eca7b43e043095d.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

exfat_update_bhs() waits for the writes it issued and then tests
!buffer_uptodate() to find the ones that failed.  That relies on the write
completion handler clearing BH_Uptodate on error, which this series
removes: a buffer whose write failed still holds the data the filesystem
asked to be written, so declaring it not up to date is wrong and makes
callers re-read it.

Test BH_Write_EIO, which is what the completion handler sets and what this
code actually wants to know.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/exfat/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index 6f11a96a4ffa..dfd0bbf31c94 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -187,7 +187,7 @@ int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync)
 
 	for (i = 0; i < nr_bhs && sync; i++) {
 		wait_on_buffer(bhs[i]);
-		if (!err && !buffer_uptodate(bhs[i]))
+		if (!err && buffer_write_io_error(bhs[i]))
 			err = -EIO;
 	}
 	return err;
-- 
2.43.0

