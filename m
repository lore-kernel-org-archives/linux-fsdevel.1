Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DDA446052;
	Tue, 13 Oct 2026 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857303; cv=none; b=IVLPq0WagBAU89AGG1OaKNWXDHJpQZKKyjevHINlC6fm5fvzCs604Ukgmt+D9362r5vCyPB/3fOMIN7R9/Rtq61NWQH7XQAO5tug5Mc/FqeRoYJEfVd7x3VKAG+pUa+dfwdvuFBAK7kPdKopw6dWGwHf/NnZLNssZ8WygtMKXyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857303; c=relaxed/simple;
	bh=9xS4EKIQwXy8lyzcTVaDoGrvaw0OsyvCwE8xGMJZHNY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpDHN2F1TuY6KuPstbE6ai+YiTYzin6DOjOIHV8AD2C3lgt6VOyhnXdb1LjgMZuMgDfJCieFVu5CY1OhqXC8f2SxRYOHar6ShKA8/iWahVcfcx1/p1Nhg1Jubj15U6ZnueVu03Lzv+zrksLHpHn6cAvBYUs6SX3lu96EvpqYQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=teZvZGRS; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="teZvZGRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791857291; bh=OHJ09hjQAz24kgDQud2tFKxx2MHWCqpL/+CT8AjLbE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=teZvZGRS63RxCVdiSfa0ic51/EsQlAd1wYCE04YfLtgjYZDW9ZZn89Zftce4KGcxB
	 PvcK6LjliyYJifdBHPCZL7OHCnZXno1du2HAm/ZmJYi6aeCuxYm5A1XuYMgHM+5SB2
	 HJN3cFXUdpyvcGO/CRyOWmhRQFdcP2Jph/SHEAiY=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 209AA6FD; Tue, 13 Oct 2026 10:08:09 +0800
X-QQ-mid: xmsmtpt1791857289tds7c8wqu
Message-ID: <tencent_08DEA270533DBF8D46589C204C5BA34A7D09@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeah+QKvN9On9vuwD1jORAVVJsINZXcx6Ozfppv64qMSUkjxhsMGGq
	 6CVPL+GjDooGbHX/FlxObIH5GlpNeI5lC58n11SaSQIbMj1iFJZqmF8GUi8VEb6e0tM0bsicwBRl
	 bmO+MdREcgdtTM7LqM+J41WZanOu2rVpcLZASW2RiAKTGRYcTCMj8Oj64fXVOTgpdlHhpItTzR7+
	 xDGCa6z3ndf76T2kbs4SWfRtCiLfPBw/Z6XKCgpJy7DpJ3sfkzacY/Tz2FVMtlAJBqrF2l93TY4w
	 6gNon1ZKXyw8yFfvyre13/RgRSv74c3N9weuY0gNbOM6i2m4twTvg1+juDL97D7GCXghwp86V+KE
	 gaziiEVoxH56zS52/O5ZAz3bLSNGt6rZeGTxlCm0WIWm/bCUTXOVpWJIwAGvinX3yS5405AgLmnn
	 83IhmeP0jJNNvExbyPR0leb/5oaCofDeZA+BU1tAKXUo+j1L8wVTbhyXyWj1GVL1LF07oKsxZbTm
	 efppFz8lHcKqkpZ3qkIlb8ENir6ilxUvdStnQIoxRu8Z+2K0OoqJyG8NsvLDGn84gOJyVslCctoC
	 +XJ3BybP5z2L7TNy9eMUAnwtHajE51pftCjjqAnh9+FJLsoKhRO1kUnaSVad1L5Z2Cc87wxdaeNz
	 K4cMX2PdGFKd7pMFIJNGupml7UBWvQE6zo4AO4OOIQcyhCsuKYfXDUSxLLdn7orW5bc4DBK5tDJ2
	 BwTZOAVFypvHgK06UyfGWsa6q5SXIHE7oYinIGcNM/qIuTPwXrWTM3jXF18BcQkDF8Tk0NymqHr4
	 EOWxqf7FszPeRSicH+b4kFj1R2VQMEO0hTOy+PrnWrTeLFyrPWZZS36LRlM3zK7cQvsRHk3GhQOj
	 WMPFBSHoBQEtyghu7gl6nzzAlveWDeDZD8NY1h/+k3syG0Yu1kHRUOv61/D/s1Re9OzhUO6VjT1Q
	 zPW0GZJGv6T8x96VIfb4Nn8laXhHmAk8jKIFvfF4Z6izu8RrDL+r1DlMz0BBb+PYTrZ4jwV9RHU1
	 FTHaztswiXLTyvmvfgX4SSWwtaqAZ55GWyrnlvpQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: 1sh1ro <yangguikun19@qq.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT] ntfs: NULL pointer dereference in ntfs_ie_add() on mkdir() in a crafted image
Date: Tue, 13 Oct 2026 10:08:09 +0800
X-OQ-MSGID: <179185728933.44204.826773478834611391@yangguikun19.qq.com>
In-Reply-To: <CAKYAXd_CP7OrKRkLwFkoLh-ADvin+oQXfj1HuDBwiEbG-LWX=Q@mail.gmail.com>
References: <tencent_8D6FD09121A77E53BCA86E1FB228DC54A107@qq.com> <CAKYAXd_CP7OrKRkLwFkoLh-ADvin+oQXfj1HuDBwiEbG-LWX=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email (mutt-like)

Hi Namjae,

Confirmed -- the patch fixes it. I applied it to a 7.2-rc5 build and re-ran the
reproducer (mount the crafted 2 MB image, then mkdir).

Unpatched (7.2-rc5, and identical on current 7.3-rc5):

  ntfs: (device loop0): ntfs_ia_open(): Failed to open index allocation of inode 5
  Oops: general protection fault ... KASAN: null-ptr-deref in range [0x20-0x27]
  RIP: 0010:ntfs_ie_add+0x40d/0x9b0
  Call Trace: ntfs_index_add_filename -> __ntfs_create -> ntfs_mkdir

With your patch (7.2-rc5 + patch):

  ntfs: (device loop0): ntfs_ia_open(): Failed to open index allocation of inode 5
  ntfs: (device loop0): ntfs_ie_add(): Failed to find place for new entry
  mkdir: cannot create directory '/mnt/t/probe': Input/output error

No oops and no KASAN report -- mkdir() now aborts cleanly through the -EIO path,
which is exactly what the -ENOENT -> -EIO change in ntfs_index_lookup() should
do. The same crash still reproduces on 7.3-rc5, so the fix is still needed
upstream.

Thanks,
1sh1ro

