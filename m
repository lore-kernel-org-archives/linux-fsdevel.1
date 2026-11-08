Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175893;
	b=rzBpntVyc7SZSBtrEXpGuhSKbSuNSPYtyzFbcsTSOpC1mhATfkf9wilcntZs/rJSuu2P
	 hpw6/QgBuwbLeh+vTr81II04mG9u9uASW0vZ8BT5OD2g0qDpiWq7vojCMTeZWmozBC5aC
	 iwPXYDlGsnRVp7Ht8eugXLRwJvUb7VZXY5ChTDyMSJdnd0ZiAc941Iz1ATL15fWhouLoq
	 sOK16tClcLm8/JvdtLWpniBuothZleNcU2QGyhKg8Fd2w1GvYrtgoHfH7lYjk5eW6XT+A
	 IivkVs9JOk/Q5ax2bJszX2Qf/Omq0ABZo3+bzTd7b8zlsdZ33F2iUOWvKGy06stzBgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AtwP5j20gn7E2EyXET3bhOC0Urzo30JN8vyaQdZ3DMA=;
	b=i8pK8unQiAjqKuBmkTqUoxs6xXPiKqmkCscfMOYsXlWercXR3yn7xp86vvilRMUbErqT
	 Ic0GzCOFC5XTCg/6nT/qFpP4vwz/srQW4IKjy+SduR5MghG1520Lt5nzEfbvUL6qVwu1d
	 EekTj+hqk5pymlAOeO+Tx6/Efew8fCCsa6xQDMMLp3w1ZI206dhFh+q3Vy0ydB2MRcPvm
	 kHDHkslxgpCuAh1AvM67ZI3H9mH/nuSreNGyddkCakgdJTNex+Hcft5YYAoE4A7nncw54
	 wn7w1vnyzHB+3ymZgY9lXL+BXhaKS5shz88wZXLs5aH0I3MkLyrmwQLO+oCgjT72Ryg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="R/lRsW7o";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CC606A31C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 22:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R/lRsW7o
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so581318c88.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794175892; x=1794780692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AtwP5j20gn7E2EyXET3bhOC0Urzo30JN8vyaQdZ3DMA=;
        b=R/lRsW7oCKLF+VFs4SbeM7nISXevZJc7zyUGcAWotAPalydatcKCAA3DjG5H3msv+M
         ZgDytWBst86rTrwPJ6wA9+1akDnJyjBvPwXajXtBVxOdmj2ljA63IjNggzLlyeriidG/
         Ya41xCiPQLdQ9h9lev7MtWbg7xLGBUHGTAfWLSr6VP52Cl8LjJEsBXBmOQW/cK5e98na
         qsYJn0kCNWf4wdnPNcc2ShRzNsI5Cr/oIORH6Lg8TE7xzirzVMMj9vpqjoXVOmxl9jue
         1R8MqK22vQ42RorlKTFqU58xn4YxM1evQJTIc3/97ias3XQx3HsH90aRTJfANbT009sg
         /c0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794175892; x=1794780692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AtwP5j20gn7E2EyXET3bhOC0Urzo30JN8vyaQdZ3DMA=;
        b=QkFm5Oxrwbs8sxWm2zfgNhNRIp/12/PsZGiTlvDfo5jcc1LgsuVENVupDy7B0NXAPB
         ki2DBKyvexxk61ZUSvlA6d/Xo6XCoCCJHaQV1rOrYbTQ+w14zd/flGLCf4cVosAjamjX
         DuMn+oIPMEY5DOTD85A47EvbJnPR9qbMEWQj3306NfQ0ro0+TXSApzFIY9AzNXoBUjML
         uataJnL72kRFVqmaRGSG9KUai40basHOolVyeFKqKwqLdLoNknWVPAhD2NJ/z5fUAWCE
         tfLji70qD+QCLgj/yOCGeKJUihNTnfNUCsubx1L0uGpLP+z9g9XnKtkVRHdrjx6Pxnzw
         blpQ==
X-Forwarded-Encrypted: i=1; AL+hErHmL+35hKiaHRjSE73l7yAUTZuhnwm9LA5j7pgYBwmnUUAMsfK64eCflA2ky8LADMwmqJcANP6Fxy8YzvVa@vger.kernel.org
X-Gm-Message-State: APuU4Z8eRMjGhUBHJRWXD7kXBFsW61WLjU+KaepMQHnVRbOsNw8kRDVW
	effGyY05PgR4gM//RD5FplEj7g/4rB1DCghYTHqAzLPBPWIbxxVXIHp2
X-Gm-Gg: AYBFou1PfAkCa3nzIWtDobhGtcQURBLyeGrbCVjGgngOfc+dYf9sOuv3c9NvTgC4zr/
	wbOabP6rB1G95/BWcjEqpPmuNBsVJMd1zNc6IQT1SWd6QxOqcIn6caAMPKbWBptDcZ3bVaANTAc
	EDkvAGfPlKPgLhkdWsT5I3V9OEfK3HKhKkQI70aJRvQDjK+qgDacDzM/mgqfH7VSzOFSk4rtpPH
	sP0sAesVui3J8HLpsY8THrzpFraU4LEFLSm3XUqL4URvhYAIlkzlcHBWA1nqhl+q5yMtwojtSQu
	G/Nlfkp4gDqbPPNFJ54k+WCKXMIvXbXE0I1583qfRFX7BbjTU4VIHJbYd2OpDV76oYypqJVnk1R
	a9FYS4se7K/G6NmNMDCXV+m7uA4CRMMBWO0md/yWqzp80PSQKnkcGfyava72MNe+ZzH6EBz0aoR
	qQxlrw6ydM7npBH9cIP1srUxOIT8G+l3Fc6YAUhgXHuIgvjqS/rKnWX751Gupx1F9RPkJxLotq9
	CExYlqqszG9/vtBaT5HeTzCG1L9Q9XnlooWer8W2strRzMO+Sq52THp8eeOVZ6q1GHjpEQY4o9G
	V0CLD6DkPJOZsuX7resKC08L9Do9FJ1j6SSC8ZdJOVF93TCUArsuNoA/l8chwsQQew==
X-Received: by 2002:a05:7022:b0c6:b0:183:e993:7901 with SMTP id a92af1059eb24-1b39fe9485dmr3817898c88.17.1794175891567;
        Sun, 08 Nov 2026 14:11:31 -0800 (PST)
Received: from anon-laptop ([103.187.196.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771f833esm7912691c88.21.2026.11.08.14.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:11:30 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: linkinjeon@kernel.org
Cc: hyc.lee@gmail.com,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ntfs: convert a named $DATA stream safely when making room in a record
Date: Mon,  9 Nov 2026 03:41:04 +0530
Message-ID: <20261108221104.1081384-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKYAXd9=crUmmGbO1vcPsdz-GmWoHxD_W_bRv2PQ_Db3Q+EkCQ@mail.gmail.com>
References: <CAKYAXd9=crUmmGbO1vcPsdz-GmWoHxD_W_bRv2PQ_Db3Q+EkCQ@mail.gmail.com>
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

Hi,

I went through Sashiko's review of v4. The WOF finding is right, and
checking the rest of its report turned up three more problems in the
same loop. I reproduced all four with a forced make-room pass and debug
delays; each fails on v4 and passes on v5, which I am sending as a
reply to this mail:

- WofCompressedData: the stream of a WOF file was converted, but
  ntfs_read_wof_chunk() reads a non-resident stream from the device, so
  the file read stale clusters until writeback (249 of 250 bytes wrong,
  correct after sync). v5 leaves the streams of a WOF file alone.

- An attribute converted in a file with no links left is evicted on the
  last iput() with its dirty folio, so an open file reads its extended
  attribute back as missing. This is older than my patch, the check
  covered only $DATA. v5 converts nothing in such a file.

- A resize of a stream or an EA converted the unnamed data of the file
  under a writer of that file (iomap_iter warnings, recursive
  mrec_lock), because only the resize of the unnamed data itself holds
  its i_rwsem. v5 converts the unnamed data only when it is the
  attribute being resized.

- The conversion of the attribute being resized waited for folio 0 with
  mrec_lock held and hangs against an mmap fault or a splice reader
  (hung task). I wrote in the mail to the v2 thread that this direct
  conversion is safe because the reader waits on i_rwsem first. That
  holds for read(), not for mmap and splice, so it was wrong. v5 uses
  FGP_NOWAIT there too. While such a reader is stuck on the lock the
  resize now fails with -ENOSPC instead of hanging, which I think is the
  better of the two, but tell me if you would rather handle it
  differently.

The six scenarios from the v4 mail still pass, and so does a WOF file
read before and after the conversion. I also ran a mutated-image fuzzer
(about 800 images, KASAN and lockdep) and the resident/non-resident
reader stress test on v5: no crash involves this code. Two things the
fuzzer hit exist without this patch as well, a WARN in iomap_iter() on
the read path of a crafted image and a lockdep report between extent_lock
and the mft runlist lock. I will look at those separately.

Thanks,
Wahid
